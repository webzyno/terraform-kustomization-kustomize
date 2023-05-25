variable "common_annotations" {
  type        = map(string)
  description = "Set Kustomize commonAnnotations using common_annotations key/value pairs."
}

variable "common_labels" {
  type        = map(string)
  description = "Set Kustomize commonLabels using common_labels key/value pairs. Sets labels and immutable labelSelectors."
}

variable "labels" {
  type = list(object({
    pairs             = map(string)
    include_selectors = bool
  }))
  description = "Set Kustomize labels using labels key/value pairs. Sets labels without also automatically injecting corresponding selectors."
}

variable "components" {
  type        = list(string)
  description = "Add one or more paths to Kustomize components to inherit from."
}

variable "config_map_generator" {
  type = list(object({
    name      = string
    namespace = string
    behavior  = string
    envs      = list(string)
    files     = list(string)
    literals  = list(string)
    options = list(object({
      labels                   = map(string)
      annotations              = map(string)
      disable_name_suffix_hash = bool
    }))
  }))
  description = "Define one or more Kustomize configMapGenerators using config_map_generator blocks."
}

variable "crds" {
  type        = list(string)
  description = "One or more paths to CRD schema definitions as expected by Kustomize."
}

variable "generators" {
  type        = list(string)
  description = "One or more paths to Kustomize generators."
}

variable "generator_options" {
  type = list(object({
    labels                   = map(string)
    annotations              = map(string)
    disable_name_suffix_hash = bool
  }))
  description = "Set options for all generators in this Kustomization."
}

variable "images" {
  type = list(object({
    name     = string
    new_name = string
    new_tag  = string
    digest   = string
  }))
  description = "Customize container images using images blocks."
}

variable "kustomize_options" {
  type = list(object({
    load_restrictor      = string
    enable_alpha_plugins = bool
    enable_exec          = bool
    enable_helm          = bool
    enable_star          = bool
    helm_path            = string
  }))
  description = "Kustomize options."
}

variable "name_prefix" {
  type        = string
  description = "Set a prefix to add to all resource names."
}

variable "namespace" {
  type        = string
  description = "Set a namespace for all namespaced resources."
}

variable "name_suffix" {
  type        = string
  description = "Set a suffix to add to all resource names."
}

variable "patches" {
  type = list(object({
    options = list(object({
      allow_kind_change = bool
      allow_name_change = bool
    }))
    path  = string
    patch = string
    target = list(object({
      group               = string
      version             = string
      kind                = string
      name                = string
      namespace           = string
      label_selector      = string
      annotation_selector = string
    }))
  }))
  description = "Define Kustomize patches to modify Kubernetes resources using patches blocks."
}

variable "replacements" {
  type = list(object({
    path = string
    source = list(object({
      group      = string
      version    = string
      kind       = string
      name       = string
      namespace  = string
      field_path = string
      options = list(object({
        delimiter = string
        index     = number
        create    = bool
      }))
    }))
    target = list(object({
      select = list(object({
        group     = string
        version   = string
        kind      = string
        name      = string
        namespace = string
      }))
      reject = list(object({
        group     = string
        version   = string
        kind      = string
        name      = string
        namespace = string
      }))
      field_paths = list(string)
      options = list(object({
        delimiter = string
        index     = number
        create    = bool
      }))
    }))
  }))
  description = "Define Kustomize replacements to modify Kubernetes resources using replacements blocks."
}

variable "replicas" {
  type = list(object({
    name  = string
    count = number
  }))
  description = "Set the Kustomize replicas to change the number of replicas of a resource."
}

variable "resources" {
  type        = list(string)
  description = "List of Kustomization resources to inherit from or include."
}

variable "secret_generator" {
  type = list(object({
    name      = string
    namespace = string
    behavior  = string
    type      = string
    envs      = list(string)
    files     = list(string)
    literals  = list(string)
    options = list(object({
      labels                   = map(string)
      annotations              = map(string)
      disable_name_suffix_hash = bool
    }))
  }))
  description = "Define one or more Kustomize secretGenerators using secret_generator blocks."
}

variable "transformers" {
  type        = list(string)
  description = "List of paths to Kustomization transformers."
}

variable "vars" {
  type = list(object({
    name = string
    obj_ref = list(object({
      api_version = string
      group       = string
      version     = string
      kind        = string
      name        = string
      namespace   = string
    }))
    field_ref = list(object({
      field_path = string
    }))
  }))
  description = "Define Kustomize vars to substitute name references. E.g. the name of a generated secret including its hash suffix."
}

variable "helm_charts" {
  type = list(object({
    name          = string
    version       = string
    repo          = string
    release_name  = string
    namespace     = string
    include_crds  = bool
    # skip_tests    = bool
    values_merge  = string
    values_file   = string
    values_inline = string
  }))
  description = "Define Kustomize helmCharts."
}

variable "helm_globals" {
  type = list(object({
    chart_home  = string
    config_home = string
  }))
  description = "Define Kustomize helmGlobals in support of helm_charts."
}