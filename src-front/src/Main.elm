module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Lazy exposing (..)
import Http
import Array
import Json.Decode as D exposing (Decoder, map5, map6, field, string)

-- MAIN
main : Program () Model Msg
main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

-------------------------------------------------------------------------------
-- MODEL
-------------------------------------------------------------------------------
type HTTPStatus
  = Loading
  | Error String
  | Success

type alias Model =
  {
    status: HTTPStatus,
    gpcontext: GPContext
  }

type alias GPContext =
  {
    envs: List GPEnv,
    filter_env: String,
    filter_type: String,
    filter_realm: String,
    filter_java_version: String,
    filter_config_version: String
  }

type alias GPEnv =
  {
    env_name: String,
    env_type: String,
    url_keycloak: String,
    version_java: List String,
    tenant: List GPTenant,
    split_database: Bool
  }

type alias GPTenant =
  {
    realm: String,
    uuid: String,
    gp_url: String,
    gp_user: String,
    version_config: List String
  }


-------------------------------------------------------------------------------
-- INIT & ERRORS HANDLING
-------------------------------------------------------------------------------

errorToString : Http.Error -> String
errorToString error =
    case error of
        Http.BadUrl url ->
            "The URL " ++ url ++ " was invalid"
        Http.Timeout ->
            "Unable to reach the server, try again"
        Http.NetworkError ->
            "Unable to reach the server, check your network connection"
        Http.BadStatus 500 ->
            "The server had a problem, try again later"
        Http.BadStatus 400 ->
            "Verify your information and try again"
        Http.BadStatus _ ->
            "Unknown error"
        Http.BadBody errorMessage ->
            errorMessage

init : () -> (Model, Cmd Msg)
init _ =
  ( (Model Loading (GPContext [] "" "" "" "" ""))
  , Http.get
      { url = "/env/query/all"
      , expect = Http.expectJson GotContext gpEnvListContextDecoder
      }
  )

-------------------------------------------------------------------------------
-- PARSING JSON
-------------------------------------------------------------------------------

gpEnvListContextDecoder : Decoder (List GPEnv)
gpEnvListContextDecoder =
    D.list gpEnvDecoder

gpEnvDecoder : Decoder GPEnv
gpEnvDecoder =
    map6 GPEnv
      (field "name" string)
      (field "type" string)
      (field "url_keycloak" string)
      (field "gp_version_java" (D.list string))
      (field "tenants" (D.list gpTenantDecoder))
      (field "split_database" D.bool)
  
gpTenantDecoder : Decoder GPTenant
gpTenantDecoder =
    map5 GPTenant 
      (field "realm" string)
      (field "uuid" string)
      (field "gp_url" string)
      (field "gp_user" string)
      (field "gp_version_config" (D.list string))
  
-------------------------------------------------------------------------------
-- SMALL CHANGES ON RESULT
-------------------------------------------------------------------------------

formatGPEnvList : List GPEnv -> List GPEnv
formatGPEnvList rawlist =
  (List.sortBy .env_name rawlist)

buildFilter : GPContext -> String
buildFilter gpcontext =
  "env=" ++ gpcontext.filter_env
  ++ "&type=" ++ gpcontext.filter_type 
  ++ "&realm=" ++ gpcontext.filter_realm 
  ++ "&jv=" ++  gpcontext.filter_java_version 
  ++ "&cv=" ++  gpcontext.filter_config_version


updateFilter : GPContext -> String -> String -> GPContext
updateFilter context field f = 
  case field of
    "env" -> {context | filter_env = f}
    "type" -> {context | filter_type = f}
    "realm" -> {context | filter_realm = f}
    "jv" -> {context | filter_java_version = f}
    "cv" -> {context | filter_config_version = f}
    _ -> context


safeGet : Int -> String -> List String -> String
safeGet idx defaultval sarray =
  (Maybe.withDefault defaultval (Array.get idx (Array.fromList sarray)))

getClassFromImportStatus : GPTenant -> String
getClassFromImportStatus tenant =
  let version = (safeGet 0 "*** Not retrievable ***" tenant.version_config)
  in
    case version of
        "*** Not retrievable ***" -> "gptenant_import_status_error"
        "No import done" -> "gptenant_import_status_sucess"
        _ -> let ist = (safeGet 1 "Unknow" tenant.version_config)
          in
            case ist of
              "SUCCESS" -> "gptenant_import_status_sucess"
              "PARTIAL" -> "gptenant_import_status_error"
              "ERROR" -> "gptenant_import_status_error"
              _ -> "gptenant_import_status_error"

-------------------------------------------------------------------------------
-- UPDATE
-------------------------------------------------------------------------------
type Msg
  = GotContext (Result Http.Error (List GPEnv))
  | FilteringEnv String
  | FilteringType String
  | FilteringRealm String
  | FilteringJV String
  | FilteringCV String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotContext result ->
      case result of
        Ok context ->
          ((Model Success 
            (GPContext (formatGPEnvList context) model.gpcontext.filter_env model.gpcontext.filter_type model.gpcontext.filter_realm model.gpcontext.filter_java_version model.gpcontext.filter_config_version)
          ), Cmd.none)
        Err error_message ->
          ({ model | status = (Error (errorToString error_message)) }, Cmd.none)
    
    FilteringEnv f ->
      let nf = (updateFilter model.gpcontext "env" f)
      in
        ((Model Success nf), 
        Http.get { url = "/env/query/" ++ buildFilter nf, expect = Http.expectJson GotContext gpEnvListContextDecoder})

    FilteringType f ->
      let nf = (updateFilter model.gpcontext "type" f)
      in
        ((Model Success nf), 
        Http.get { url = "/env/query/" ++ buildFilter nf, expect = Http.expectJson GotContext gpEnvListContextDecoder})

    FilteringRealm f ->
      let nf = (updateFilter model.gpcontext "realm" f)
      in
        ((Model Success nf), 
        Http.get { url = "/env/query/" ++ buildFilter nf, expect = Http.expectJson GotContext gpEnvListContextDecoder})

    FilteringJV f ->
      let nf = (updateFilter model.gpcontext "jv" f)
      in
        ((Model Success nf), 
        Http.get { url = "/env/query/" ++ buildFilter nf, expect = Http.expectJson GotContext gpEnvListContextDecoder})

    FilteringCV f ->
      let nf = (updateFilter model.gpcontext "cv" f)
      in
        ((Model Success nf), 
        Http.get { url = "/env/query/" ++ buildFilter nf, expect = Http.expectJson GotContext gpEnvListContextDecoder})
          

-------------------------------------------------------------------------------
-- SUBSCRIPTIONS
-------------------------------------------------------------------------------
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-------------------------------------------------------------------------------
-- VIEW
-------------------------------------------------------------------------------

view : Model -> Html Msg
view model =
  div []
    [ case model.status of
      Loading ->
        h2 [] [text "Loading..."]

      Error error_message ->
        h2 [][text ("Error loading the dashboard : " ++ error_message)]

      Success ->
        div [ class "main" ] 
        (List.append
          [
            h2 [] [text "Currents GP environments"],

            div [ class "links" ]
            [
              a [ class "link", href "/reload_from_cache"] [ text "Reload from cache" ]
            ],
            
            view_filter model
          ]

          [div [ class "gp_env_list" ]
            (List.map view_gpenv model.gpcontext.envs)]
        )
    ]


view_filter  : Model -> Html Msg
view_filter model =
  div [ class "filter" ]
    [
      viewInput "text" "Env to filter" model.gpcontext.filter_env FilteringEnv
      , viewInput "text" "Type to filter" model.gpcontext.filter_type FilteringType
      , viewInput "text" "Realm to filter" model.gpcontext.filter_realm FilteringRealm
      , viewInput "text" "Java version to filter" model.gpcontext.filter_java_version FilteringJV
      --, viewInput "text" "Config version to filter" model.gpcontext.filter_config_version FilteringCV
      , a [ class "link", href ("/env/csv/" ++ (buildFilter model.gpcontext)) ] [ text "Export to CSV" ]
    ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  span [ class "filter_input" ]
    [ input [ type_ t, placeholder p, value v, onInput toMsg ] [] ]


view_gpenv : GPEnv -> Html Msg
view_gpenv data =
  div [ class "gpenv" ] 
     [
        span [ class "gpenv_name" ] [text data.env_name],

        (if data.split_database then
          span [ class "gpenv_db_split" ] [text "(split db)"]
        else
          span [ class "gpenv_db_split" ] [text "(old)"]
        ),

        span [ class "gpenv_envtype" ] [text data.env_type],
        (view_java_version data.version_java),
        div [ class "gpenv_tenant_list" ] (List.map view_tenant data.tenant)
     ]
     

view_java_version : (List String) -> Html Msg
view_java_version strs =
  div [ class "gpenv_version_java" ]
      [
        span [ class "str java_version" ] [ text (safeGet 0 "java version" strs)]
        ,span [ class "str java_commit_id" ] [ text (safeGet 1 "commit id" strs)]
      ]


view_tenant : GPTenant -> Html Msg
view_tenant data =
  div [ class (getClassFromImportStatus data) ]
    [
      span [ class "gptenant_realm" ] [ a [ class "link", href data.gp_url ] [ text data.realm ] ]
      , (view_config_version data.version_config)
      --, span [ class "gptenant_url" ] [text data.gp_url]
    ]


view_config_version : (List String) -> Html Msg
view_config_version strs =
  span [ class "gptenant_version_config" ]
      [
        span [ class "str config_import_version" ] [ text (safeGet 0 "Config version" strs)],

        (let importstatus = (safeGet 1 "Import Status" strs)
        in
          case importstatus of
              "SUCCESS" -> span [ class "str" ] [ ]
              _ -> span [ class "str config_import_status" ] [ text importstatus]
        ),
        
        (let importdate = (safeGet 2 "Import date" strs)
        in
          if (String.length importdate) > 19 then
            span [ class "str config_import_date" ] [ text (String.slice 0 19 importdate)]
          else
            span [ class "str config_import_date" ] [ text importdate]
        )
        
        -- let comment = (safeGet 3 "Comment" strs)
        -- in
        --   if not (String.isEmpty comment) then
        --     span [ class "str config_import_comment" ] [ text comment]
        --   else
        --     span [ ] [ ]
      ]

