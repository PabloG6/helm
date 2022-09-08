defmodule Helm.Chart do
  @moduledoc """
  --atomic                                     if set, the installation process deletes the installation on failure. The --wait flag will be set automatically if --atomic is used
  --ca-file string                             verify certificates of HTTPS-enabled servers using this CA bundle
  --cert-file string                           identify HTTPS client using this SSL certificate file
  --create-namespace                           create the release namespace if not present
  --dependency-update                          update dependencies if they are missing before installing the chart
  --description string                         add a custom description
  --devel                                      use development versions, too. Equivalent to version '>0.0.0-0'. If --version is set, this is ignored
  --disable-openapi-validation                 if set, the installation process will not validate rendered templates against the Kubernetes OpenAPI Schema
  --dry-run                                    simulate an install
  -g, --generate-name                              generate the name (and omit the NAME parameter)
  --insecure-skip-tls-verify                   skip tls certificate checks for the chart download
  --key-file string                            identify HTTPS client using this SSL key file
  --keyring string                             location of public keys used for verification (default "~/.gnupg/pubring.gpg")
  --name-template string                       specify template used to name the release
  --no-hooks                                   prevent hooks from running during install
  -o, --output format                              prints the output in the specified format. Allowed values: table, json, yaml (default table)
  --pass-credentials                           pass credentials to all domains
  --password string                            chart repository password where to locate the requested chart
  --post-renderer postRendererString           the path to an executable to be used for post rendering. If it exists in $PATH, the binary will be used, otherwise it will try to look for the executable at the given path
  --post-renderer-args postRendererArgsSlice   an argument to the post-renderer (can specify multiple) (default [])
  --render-subchart-notes                      if set, render subchart notes along with the parent
  --replace                                    re-use the given name, only if that name is a deleted release which remains in the history. This is unsafe in production
  --repo string                                chart repository url where to locate the requested chart
  --set stringArray                            set values on the command line (can specify multiple or separate values with commas: key1=val1,key2=val2)
  --set-file stringArray                       set values from respective files specified via the command line (can specify multiple or separate values with commas: key1=path1,key2=path2)
  --set-string stringArray                     set STRING values on the command line (can specify multiple or separate values with commas: key1=val1,key2=val2)
  --skip-crds                                  if set, no CRDs will be installed. By default, CRDs are installed if not already present
  --timeout duration                           time to wait for any individual Kubernetes operation (like Jobs for hooks) (default 5m0s)
  --username string                            chart repository username where to locate the requested chart
  -f, --values strings                             specify values in a YAML file or a URL (can specify multiple)
  --verify                                     verify the package before using it
  --version string                             specify a version constraint for the chart version to use. This constraint can be a specific tag (e.g. 1.1.1) or it may reference a valid range (e.g. ^2.0.0). If this is not specified, the latest version is used
  --wait                                       if set, will wait until all Pods, PVCs, Services, and minimum number of Pods of a Deployment, StatefulSet, or ReplicaSet are in a ready state before marking the release as successful. It will wait for as long as --timeout
  --wait-for-jobs                              if set and --wait enabled, will wait until all Jobs have been completed before marking the release as successful. It will wait for as long as --timeout

  """

  import Helm.Core.Cmd

  defstruct [
    :values,
    :set_file,
    :ca_file,
    :cert_file,
    :atomic,
    :description,
    :repo,
    :name,
    :wait,
    :key_file,
    :keyring,
    :name_template,
    :username,
    :password,
    :insecure_skip_tls_verify,
    :render_subchart_notes,
    :replace,
    :pass_credentials,
    :create_namespace,
    :dry_run,
    :generate_name,
    :debug,
    :no_hooks,
    :skip_crds,
    :timeout,
    :dependency_update,
    :verify,
    :wait_for_jobs,
    :chart,

  ]


  @install_flags [
    {:name, :required},
    {:chart, :required},
    {:repo, :string},
    {:description, :string},
    {:timeout, :string},
    {:username, :string},
    {:password, :string},
    :atomic,
    :create_namespace,
    :dependency_update,
    :debug,

    :devel,
    :disable_openapi_validation,
    :dry_run,
    :generate_name,
    :insecure_skip_tls_verify,
    :no_hooks,
    :pass_credentials,
    :post_renderer_args,
    :render_subchart_notes,
    :replace,

    :values,
    :verify,
    :version,
    :wait,
    :wait_for_jobs,

  ]


  @uninstall_flags [
    {:name, :required},
    {:description, :string},
    {:timeout, :string},
    :dry_run,
    :help,
    :keep_history,
    :no_hooks,



  ]
  def create_chart(%__MODULE__{} = options) do

    build_command(["install"], options, @install_flags)
  end


  def delete_chart(%__MODULE__{} = options) do
    build_command(["uninstall"], options, @uninstall_flags)
  end


  def list_releases() do

  end




end
