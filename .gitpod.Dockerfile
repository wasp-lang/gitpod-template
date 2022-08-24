FROM gitpod/workspace-full:latest

ENV WASP_TELEMETRY_CONTEXT=gitpod

RUN curl -sSL https://get.wasp-lang.dev/installer.sh | sh \
	&& printf '%s\n' 'export WASP_TELEMETRY_USER_ID=$GITPOD_WORKSPACE_ID' \
		'export REACT_APP_API_URL="$(gp url 3001)"' > $HOME/.bashrc.d/700-wasp
