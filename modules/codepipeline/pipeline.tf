resource "aws_codepipeline" "codepipeline" {
  name     = "tf-test-pipeline"
  role_arn = aws_iam_role.codepipeline.arn

  artifact_store {
    location = aws_s3_bucket.artifacts.bucket
    type     = "S3"

    encryption_key {
      id   = data.aws_kms_alias.s3kmskey.arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName   = aws_codecommit_repository.repo.repository_id
        BranchName = "master"
        PollForSourceChanges = true
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Plan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.plan.id
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CloudFormation"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ActionMode     = "REPLACE_ON_FAILURE"
        Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
        OutputFileName = "CreateStackOutput.json"
        StackName      = "MyStack"
        TemplatePath   = "build_output::sam-templated.yaml"
      }
    }
  }
}

# name - (Required) The name of the pipeline.
# role_arn - (Required) A service role Amazon Resource Name (ARN) that grants AWS CodePipeline permission to make calls to AWS services on your behalf.
# artifact_store (Required) One or more artifact_store blocks. Artifact stores are documented below.
# stage (Minimum of at least two stage blocks is required) A stage block. Stages are documented below.
# tags - (Optional) A map of tags to assign to the resource.
# An artifact_store block supports the following arguments:

# location - (Required) The location where AWS CodePipeline stores artifacts for a pipeline; currently only S3 is supported.
# type - (Required) The type of the artifact store, such as Amazon S3
# encryption_key - (Optional) The encryption key block AWS CodePipeline uses to encrypt the data in the artifact store, such as an AWS Key Management Service (AWS KMS) key. If you don't specify a key, AWS CodePipeline uses the default key for Amazon Simple Storage Service (Amazon S3). An encryption_key block is documented below.
# region - (Optional) The region where the artifact store is located. Required for a cross-region CodePipeline, do not provide for a single-region CodePipeline.
# An encryption_key block supports the following arguments:

# id - (Required) The KMS key ARN or ID
# type - (Required) The type of key; currently only KMS is supported
# A stage block supports the following arguments:

# name - (Required) The name of the stage.
# action - (Required) The action(s) to include in the stage. Defined as an action block below
# An action block supports the following arguments:

# category - (Required) A category defines what kind of action can be taken in the stage, and constrains the provider type for the action. Possible values are Approval, Build, Deploy, Invoke, Source and Test.
# owner - (Required) The creator of the action being called. Possible values are AWS, Custom and ThirdParty.
# name - (Required) The action declaration's name.
# provider - (Required) The provider of the service being called by the action. Valid providers are determined by the action category. For example, an action in the Deploy category type might have a provider of AWS CodeDeploy, which would be specified as CodeDeploy.
# version - (Required) A string that identifies the action type.
# configuration - (Optional) A Map of the action declaration's configuration. Find out more about configuring action configurations in the Reference Pipeline Structure documentation.
# input_artifacts - (Optional) A list of artifact names to be worked on.
# output_artifacts - (Optional) A list of artifact names to output. Output artifact names must be unique within a pipeline.
# role_arn - (Optional) The ARN of the IAM service role that will perform the declared action. This is assumed through the roleArn for the pipeline.
# run_order - (Optional) The order in which actions are run.
# region - (Optional) The region in which to run the action.
# namespace - (Optional) The namespace all output variables will be accessed from.
# Note: The input artifact of an action must exactly match the output artifact declared in a preceding action, but the input artifact does not have to be the next action in strict sequence from the action that provided the output artifact. Actions in parallel can declare different output artifacts, which are in turn consumed by different following actions.
