function immich -d "Upload to immich"
    argparse -i 'folders-as-tags' 'album=' 'dry-run' -- $argv
    or return

    set -l cmd immich-go upload from-folder . --api-key "$IMMICH_API_KEY" --admin-api-key "$IMMICH_ADMIN_API_KEY" --server "$IMMICH_URL"

    if set -q _flag_album
        set -a cmd --into-album "$_flag_album"
    end
    if set -q _flag_dry_run
        set -a cmd --dry-run
    end
    if set -q _flag_folders_as_tags
        set -a cmd --folder-as-tags=true
    end

    $cmd $argv
end
