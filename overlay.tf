data "kustomization_overlay" "this" {
  common_annotations = var.common_annotations
  common_labels      = var.common_labels

  dynamic "labels" {
    for_each = var.labels
    content {
      pairs             = labels.value.pairs
      include_selectors = labels.value.include_selectors
    }
  }

  components = var.components

  dynamic "config_map_generator" {
    for_each = var.config_map_generator
    content {
      name      = config_map_generator.value.name
      namespace = config_map_generator.value.namespace
      behavior  = config_map_generator.value.behavior
      envs      = config_map_generator.value.envs
      files     = config_map_generator.value.files
      literals  = config_map_generator.value.literals

      dynamic "options" {
        for_each = config_map_generator.value.options
        content {
          labels                   = options.value.labels
          annotations              = options.value.annotations
          disable_name_suffix_hash = options.value.disable_name_suffix_hash
        }
      }
    }
  }

  crds       = var.crds
  generators = var.generators

  dynamic "generator_options" {
    for_each = var.generator_options
    content {
      labels                   = generator_options.value.labels
      annotations              = generator_options.value.annotations
      disable_name_suffix_hash = generator_options.value.disable_name_suffix_hash
    }
  }

  dynamic "images" {
    for_each = var.images
    content {
      name     = images.value.name
      new_name = images.value.new_name
      new_tag  = images.value.new_tag
      digest   = images.value.digest
    }
  }

  dynamic "kustomize_options" {
    for_each = var.kustomize_options
    content {
      load_restrictor      = kustomize_options.value.load_restrictor
      enable_alpha_plugins = kustomize_options.value.enable_alpha_plugins
      enable_exec          = kustomize_options.value.enable_exec
      enable_helm          = kustomize_options.value.enable_helm
      enable_star          = kustomize_options.value.enable_star
      helm_path            = kustomize_options.value.helm_path
    }
  }

  name_prefix = var.name_prefix
  namespace   = var.namespace
  name_suffix = var.name_suffix

  dynamic "patches" {
    for_each = var.patches
    content {
      dynamic "options" {
        for_each = patches.value.options
        content {
          allow_kind_change = options.value.allow_kind_change
          allow_name_change = options.value.allow_name_change
        }
      }

      path  = patches.value.path
      patch = patches.value.patch

      dynamic "target" {
        for_each = patches.value.target
        content {
          group               = target.value.group
          version             = target.value.version
          kind                = target.value.kind
          name                = target.value.name
          namespace           = target.value.namespace
          label_selector      = target.value.label_selector
          annotation_selector = target.value.annotation_selector
        }
      }
    }
  }

  dynamic "replacements" {
    for_each = var.replacements
    content {
      path = replacements.value.path

      dynamic "source" {
        for_each = replacements.value.source
        content {
          group      = source.value.group
          version    = source.value.version
          kind       = source.value.kind
          name       = source.value.name
          namespace  = source.value.namespace
          field_path = source.value.field_path

          dynamic "options" {
            for_each = source.value.options
            content {
              delimiter = options.value.delimiter
              index     = options.value.index
              create    = options.value.create
            }
          }
        }
      }

      dynamic "target" {
        for_each = replacements.value.target
        content {
          dynamic "select" {
            for_each = target.value.select
            content {
              group     = select.value.group
              version   = select.value.version
              kind      = select.value.kind
              name      = select.value.name
              namespace = select.value.namespace
            }
          }

          dynamic "reject" {
            for_each = target.value.reject
            content {
              group     = reject.value.group
              version   = reject.value.version
              kind      = reject.value.kind
              name      = reject.value.name
              namespace = reject.value.namespace
            }
          }

          field_paths = target.value.field_paths

          dynamic "options" {
            for_each = target.value.options
            content {
              delimiter = options.value.delimiter
              index     = options.value.index
              create    = options.value.create
            }
          }
        }
      }
    }
  }

  dynamic "replicas" {
    for_each = var.replicas
    content {
      name  = replicas.value.name
      count = replicas.value.count
    }
  }

  resources = var.resources

  dynamic "secret_generator" {
    for_each = var.secret_generator
    content {
      name      = secret_generator.value.name
      namespace = secret_generator.value.namespace
      behavior  = secret_generator.value.behavior
      type      = secret_generator.value.type
      envs      = secret_generator.value.envs
      files     = secret_generator.value.files
      literals  = secret_generator.value.literals

      dynamic "options" {
        for_each = secret_generator.value.options
        content {
          labels                   = options.value.labels
          annotations              = options.value.annotations
          disable_name_suffix_hash = options.value.disable_name_suffix_hash
        }
      }
    }
  }

  transformers = var.transformers

  dynamic "vars" {
    for_each = var.vars
    content {
      name = vars.value.name

      dynamic "obj_ref" {
        for_each = vars.value.obj_ref
        content {
          api_version = obj_ref.value.api_version
          group       = obj_ref.value.group
          version     = obj_ref.value.version
          kind        = obj_ref.value.kind
          name        = obj_ref.value.name
          namespace   = obj_ref.value.namespace
        }
      }

      dynamic "field_ref" {
        for_each = vars.value.field_ref
        content {
          field_path = field_ref.value.field_path
        }
      }
    }
  }

  dynamic "helm_charts" {
    for_each = var.helm_charts
    content {
      name         = helm_charts.value.name
      version      = helm_charts.value.version
      repo         = helm_charts.value.repo
      release_name = helm_charts.value.release_name
      namespace    = helm_charts.value.namespace
      include_crds = helm_charts.value.include_crds
      # skip_tests    = helm_charts.value.skip_tests
      values_merge  = helm_charts.value.values_merge
      values_file   = helm_charts.value.values_file
      values_inline = helm_charts.value.values_inline
    }
  }

  dynamic "helm_globals" {
    for_each = var.helm_globals
    content {
      chart_home  = helm_globals.value.chart_home
      config_home = helm_globals.value.config_home
    }
  }
}
