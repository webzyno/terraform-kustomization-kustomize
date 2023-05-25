variable "common_annotations" {
  type        = map(string)
  description = "Set Kustomize commonAnnotations using common_annotations key/value pairs."
  default     = null
}

variable "common_labels" {
  type        = map(string)
  description = "Set Kustomize commonLabels using common_labels key/value pairs. Sets labels and immutable labelSelectors."
  default     = null
}

variable "labels" {
  type = list(object({
    pairs             = optional(map(string), null)
    include_selectors = optional(bool, null)
  }))
  description = "Set Kustomize labels using labels key/value pairs. Sets labels without also automatically injecting corresponding selectors."
  default     = []
}

variable "components" {
  type        = list(string)
  description = "Add one or more paths to Kustomize components to inherit from."
  default     = null
}

variable "config_map_generator" {
  type = list(object({
    name      = optional(string, null)
    namespace = optional(string, null)
    behavior  = optional(string, null)
    envs      = optional(list(string), null)
    files     = optional(list(string), null)
    literals  = optional(list(string), null)
    options = optional(list(object({
      labels                   = optional(map(string), null)
      annotations              = optional(map(string), null)
      disable_name_suffix_hash = optional(bool, null)
    })), null)
  }))
  description = "Define one or more Kustomize configMapGenerators using config_map_generator blocks."
  default     = []
}

variable "crds" {
  type        = list(string)
  description = "One or more paths to CRD schema definitions as expected by Kustomize."
  default     = null
}

variable "generators" {
  type        = list(string)
  description = "One or more paths to Kustomize generators."
  default     = null
}

variable "generator_options" {
  type = list(object({
    labels                   = optional(map(string), null)
    annotations              = optional(map(string), null)
    disable_name_suffix_hash = optional(bool, null)
  }))
  description = "Set options for all generators in this Kustomization."
  default     = []
}

variable "images" {
  type = list(object({
    name     = optional(string, null)
    new_name = optional(string, null)
    new_tag  = optional(string, null)
    digest   = optional(string, null)
  }))
  description = "Customize container images using images blocks."
  default     = []
}

variable "kustomize_options" {
  type = list(object({
    load_restrictor      = optional(string, null)
    enable_alpha_plugins = optional(bool, null)
    enable_exec          = optional(bool, null)
    enable_helm          = optional(bool, null)
    enable_star          = optional(bool, null)
    helm_path            = optional(string, null)
  }))
  description = "Kustomize options."
  default     = []
}

variable "name_prefix" {
  type        = string
  description = "Set a prefix to add to all resource names."
  default     = null
}

variable "namespace" {
  type        = string
  description = "Set a namespace for all namespaced resources."
  default     = null
}

variable "name_suffix" {
  type        = string
  description = "Set a suffix to add to all resource names."
  default     = null
}

variable "patches" {
  type = list(object({
    options = optional(list(object({
      allow_kind_change = optional(bool, null)
      allow_name_change = bool
    })), null)
    path  = optional(string, null)
    patch = optional(string, null)
    target = optional(list(object({
      group               = optional(string, null)
      version             = optional(string, null)
      kind                = optional(string, null)
      name                = optional(string, null)
      namespace           = optional(string, null)
      label_selector      = optional(string, null)
      annotation_selector = optional(string, null)
    })), null)
  }))
  description = "Define Kustomize patches to modify Kubernetes resources using patches blocks."
  default     = []
}

variable "replacements" {
  type = list(object({
    path = optional(string, null)
    source = optional(list(object({
      group      = optional(string, null)
      version    = optional(string, null)
      kind       = optional(string, null)
      name       = optional(string, null)
      namespace  = optional(string, null)
      field_path = optional(string, null)
      options = optional(list(object({
        delimiter = optional(string, null)
        index     = optional(number, null)
        create    = optional(bool, null)
      })), null)
    })), null)
    target = optional(list(object({
      select = optional(list(object({
        group     = optional(string, null)
        version   = optional(string, null)
        kind      = optional(string, null)
        name      = optional(string, null)
        namespace = optional(string, null)
      })), null)
      reject = optional(list(object({
        group     = optional(string, null)
        version   = optional(string, null)
        kind      = optional(string, null)
        name      = optional(string, null)
        namespace = optional(string, null)
      })), null)
      field_paths = optional(list(string), null)
      options = optional(list(object({
        delimiter = optional(string, null)
        index     = optional(number, null)
        create    = optional(bool, null)
      })), null)
    })), null)
  }))
  description = "Define Kustomize replacements to modify Kubernetes resources using replacements blocks."
  default     = []
}

variable "replicas" {
  type = list(object({
    name  = optional(string, null)
    count = optional(number, null)
  }))
  description = "Set the Kustomize replicas to change the number of replicas of a resource."
  default     = []
}

variable "resources" {
  type        = list(string)
  description = "List of Kustomization resources to inherit from or include."
  default     = null
}

variable "secret_generator" {
  type = list(object({
    name      = optional(string, null)
    namespace = optional(string, null)
    behavior  = optional(string, null)
    type      = optional(string, null)
    envs      = optional(list(string), null)
    files     = optional(list(string), null)
    literals  = optional(list(string), null)
    options = optional(list(object({
      labels                   = optional(map(string), null)
      annotations              = optional(map(string), null)
      disable_name_suffix_hash = optional(bool, null)
    })), null)
  }))
  description = "Define one or more Kustomize secretGenerators using secret_generator blocks."
  default     = []
}

variable "transformers" {
  type        = list(string)
  description = "List of paths to Kustomization transformers."
  default     = null
}

variable "vars" {
  type = list(object({
    name = string
    obj_ref = list(object({
      api_version = optional(string, null)
      group       = optional(string, null)
      version     = optional(string, null)
      kind        = optional(string, null)
      name        = optional(string, null)
      namespace   = optional(string, null)
    }))
    field_ref = optional(list(object({
      field_path = optional(string, null)
    })), null)
  }))
  description = "Define Kustomize vars to substitute name references. E.g. the name of a generated secret including its hash suffix."
  default     = []
}

variable "helm_charts" {
  type = list(object({
    name         = optional(string, null)
    version      = optional(string, null)
    repo         = optional(string, null)
    release_name = optional(string, null)
    namespace    = optional(string, null)
    include_crds = optional(bool, null)
    # skip_tests    = bool
    values_merge  = optional(string, null)
    values_file   = optional(string, null)
    values_inline = optional(string, null)
  }))
  description = "Define Kustomize helmCharts."
  default     = []
}

variable "helm_globals" {
  type = list(object({
    chart_home  = optional(string, null)
    config_home = optional(string, null)
  }))
  description = "Define Kustomize helmGlobals in support of helm_charts."
  default     = []
}
