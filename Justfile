# Build a production release
release:
    MIX_ENV=prod mix deps.get --only prod
    MIX_ENV=prod mix compile
    MIX_ENV=prod mix assets.deploy
    MIX_ENV=prod mix release
    tar -czf app.tar.gz -C _build/prod/rel yodel_studio
    @echo "Release packaged as app.tar.gz"

# Clean build artifacts and digested assets
clean:
    mix phx.digest.clean --all
