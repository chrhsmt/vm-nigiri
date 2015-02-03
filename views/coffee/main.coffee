jQuery ->
    $.ajax {
        type: 'GET'
        url: '/instances'
        dataType: "json"
        success: (json)->
            console.log "success"
            # console.log json
            for instance in json
                row = $("#instances tr.trow").clone()
                console.log instance.id
                $(row.find("td")[0]).html(instance.id)
                $(row.find("td")[1]).html(instance.name)
                $(row.find("td")[2]).html(instance.ip)
                $(row.find("td")[3]).html(instance.machine.name)
                $(row.find("td")[4]).html(instance.disk_size)
                $(row.find("td")[5]).html(instance.memory)
                $(row.find("td")[6]).html(instance.macaddr)
                $(row.find("td")[7]).html(instance.telnet_port)
                $(row.find("td")[8]).html(instance.status)
                $(row.find("td")[9]).html(instance.key.id) if instance.key
                row.removeAttr "class"
                $("#instances").append row
            $("#instances tr.trow").remove()
        error: (json)->
            console.log json
        complete: (json)->
            console.log "complete"
            console.log json
    }
    # button_selector = "button#call"
    # $("body").delegate button_selector, "click", () ->
    #     if $("input#tel").val().length == 0
    #         $(".alert").addClass('in alert-danger')
    #         $(".alert").text('電話番号を入力してください。')
    #     else
    #         ga('send', 'event', 'twilio', 'call', 'tel', $("input#tel").val());
    #         $(".alert").removeClass('in alert-danger alert-success')
    #         $(button_selector).button 'loading'
    #         $.ajax {
    #             url: "/call"
    #             type: "POST"
    #             dataType: "json"
    #             data: {
    #                 tel: $("input#tel").val()
    #             }
    #             success: (json) ->
    #                 msg = 'call中です。少々お待ちくださいませ。<br />' + 
    #                     "<small text-left>※本アプリケーションは1コール毎に通話料が掛かっております...。<br />" + 
    #                     "できましたら広告主様へご助力いただけますと助かります。</small>"
    #                 $(".alert").addClass('in alert-success')
    #                 $(".alert").html(msg)
    #             error: (json) ->
    #                 $(".alert").addClass('in alert-danger')
    #                 $(".alert").text('エラーが発生しました')
    #             complete: (xhr, status) ->
    #                 $(button_selector).button 'reset'
    #         }