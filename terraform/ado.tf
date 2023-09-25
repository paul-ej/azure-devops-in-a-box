# The terraform in this file configures an Azure DevOp projectm plus a 

resource "azuredevops_project" "proj-ado-in-a-box" {
    project_name    = var.project_name
    description     = var.description
    visibility      = var.visibility
    version_control = var.version_control
    # Features to be enabled in ADO project
    features = {
        "boards" = "disabled"
        "repositories" = "enabled"
        "pipelines"    = "enabled"
        "testplans"    = "enabled"
        "artifacts"    = "enabled"
    }

    depends_on = [ 
        azurerm_key_vault.cfp_demo_kv
     ]
}

resource "azuredevops_git_repository" "cfp_demo" {
    project_id    = azuredevops_project.proj-ado-in-a-box.id
    name          = var.repo_name
    initialization {
      init_type   = "Clean"
      source_type = "Git"
    }

    depends_on = [ azuredevops_project.proj-ado-in-a-box ]
}

resource "azuredevops_variable_group" "cfg_demo_vars" {
  project_id   = azuredevops_project.proj-ado-in-a-box.id
  name         = azuredevops_project.proj-ado-in-a-box.name
  description  = "Var groups managed by terraform"
  allow_access = true

  variable {
    value1 = ""
    value2 = ""
  }

  depends_on = [ azuredevops_git_repository.cfp_demo ]
}

resource "azuredevops_build_definition" "cfg_demo_build_def" {
  project_id = azuredevops_project.proj-ado-in-a-box.id
  name       = "Sample build definition"
  path       = "\\TestFolder"

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type   = "TfsGit"
    repo_id     = azuredevops_git_repository.cfp_demo.id
    branch_name = azuredevops_git_repository.cfp_demo.default_branch
    yml_path    = "azure-pipelines.yaml"
  }

  variable_groups = [
    azuredevops_variable_group.cfg_demo_vars.id
  ]

  variable {
  # Populate with pipeline variables
  }

  depends_on = [ azuredevops_variable_group.cfg_demo_vars ]
}