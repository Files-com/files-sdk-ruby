var Zap = {
    // This trigger is used to populate other fields only, so we take some shortcuts.
    new_subfolder_poll: function(bundle) {
        var results = [];
        delete bundle.request.headers['Content-Type'];
        bundle.request.params.per_page = 5000;
        bundle.request.params.page = 1;

        var url_length = bundle.request.url.length;
        if (bundle.request.url.substring(url_length - 8) === "{{path}}") {
            bundle.request.url = bundle.request.url.substring(0, url_length - 8);
        }

        var response = JSON.parse(z.request(bundle.request).content);

        for (var i = 0; i < response.length; i++) {
            if (response[i].type === "directory") {
                results.push(response[i]);
            }
        }

        return results;
    },

    new_file_uploaded_poll: function(bundle) {
        var results = [];
        var per_page = 5000;
        var page = 1;

        delete bundle.request.headers['Content-Type'];
        bundle.request.params.per_page = per_page;

        var url_length = bundle.request.url.length;
        if (bundle.request.url.substring(url_length - 8) === "{{path}}") {
            bundle.request.url = bundle.request.url.substring(0, url_length - 8);
        }

        for (;;) {
            bundle.request.params.page = page;
            var one_result = JSON.parse(z.request(bundle.request).content);

            for (var i = 0; i < one_result.length; i++) {
                // Turns out we don't need to set ID, but left it in here just in
                // case we want it in the future.
                //one_result[i].id = one_result[i].path;

                var path = one_result[i].path;
                var basename = path.substring(path.lastIndexOf("/") + 1);
                one_result[i].basename = basename;
                one_result[i].id = path; // added by bryan@zapier.com

                if (one_result[i].type === "file") {
                    var file_url = bundle.request.url.replace("/folders", "/files") + "/" + basename + "?action=redirect";
                    one_result[i].file = z.dehydrateFile(file_url, {method: "GET", headers: {"Authorization": "Basic " + btoa(bundle.request.auth[0] + ":x")}});
                }
                else {
                    one_result[i].file = "";
                }
            }

            results = results.concat(one_result);
            if (one_result.length === per_page) {
                page += 1;
            }
            else {
                return results;
            }
        }
    },

    // On the create_permission action, we need to strip a leading slash from
    // the path field. This also makes it possible to send a blank path, which
    // is the correct input for the Root Folder. Updated: also handles the case
    // where the path is not defined, as it is an optional field.
    create_permission_pre_write: function(bundle) {
        var data = JSON.parse(bundle.request.data);
        if (typeof(data.path) === 'undefined') {
            data.path = '';
        }
        else if (data.path.substr(0, 1) === '/') {
            data.path = data.path.substr(1);
        }
        bundle.request.data = JSON.stringify(data);
        return bundle.request;
    },

    upload_file_from_trigger_pre_write: function(bundle) {
        bundle.request.url = bundle.request.url.replace("/files/{{upload_folder}}/", "/files/").replace("{{file_name}}", bundle.request.files.file[0]);
        bundle.request.params.action = "attachment";
        return bundle.request;
    }
};
