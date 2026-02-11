{config, ... }: {
  programs.claude-code = {
    enable = true;
  };

  home.sessionVariables = {
    ANTHROPIC_BASE_URL = "https://litellm.pco-eu-infratest-sand.aws.pictet.cloud";

    # Clé API LiteLLM
    ANTHROPIC_AUTH_TOKEN = "$(cat ${config.sops.templates.litellm_token.path})";

    # Modèle Bedrock via LiteLLM
    ANTHROPIC_DEFAULT_SONNET_MODEL = "bedrock/eu.anthropic.claude-sonnet-4-5-20250929-v1:0";
    ANTHROPIC_DEFAULT_HAIKU_MODEL = "bedrock/eu.anthropic.claude-haiku-4-5-20251001-v1:0";
    ANTHROPIC_DEFAULT_OPUS_MODEL = "bedrock/global.anthropic.claude-opus-4-5-20251101-v1:0";

    # Désactiver les headers beta
    CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS = 1;

    # Désactiver le prompt cache
    DISABLE_PROMPT_CACHING = 1;
    LITELLM_TOKEN = "$(cat ${config.sops.templates.litellm_token.path})";
  };
}
