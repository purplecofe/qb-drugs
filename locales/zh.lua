local Translations = {
    error = {
        has_no_drugs = "你身上沒有任何毒品",
        not_enough_police = "人們現在對毒品沒有興趣",
        no_drugs_left = "沒有更多的毒品可以賣了",
        too_far_away = "你移動的太遠了",
        offer_declined = "拒絕報價",
        no_player_nearby = "附近沒有玩家",
        pending_delivery = "你還有貨要交，你在等什麼?",
        item_unavailable = "你收到退款了，因為這個東西沒有了",
        order_not_right = "這不符合訂單需求",
        too_late = "你遲到了",
        dealer_already_exists = "A dealer already exists with this name",
        dealer_not_exists = "This dealer doesn't exist",
        no_dealers = "No dealers have been placed",
        dealer_not_exists_command = "Dealer %{dealerName} doesn't exist"
    },
    success = {
        helped_player = "You helped a person up",
        route_has_been_set = "到交貨地點的 GPS 已經在你的地圖上設定好",
        teleported_to_dealer = "You have been teleported to %{dealerName}",
        offer_accepted = "成交",
        order_delivered = "訂單已交付",
        dealer_deleted = "Dealer %{dealerName} has been deleted"
    },
    info = {
        started_selling_drugs = "你可以開始販毒了",
        stopped_selling_drugs = "你停止販毒了",
        has_been_robbed = "你被搶了 %{bags} 個 %{drugType}",
        suspicious_situation = "Suspicious situation",
        possible_drug_dealing = "Possible drug dealing",
        drug_offer = "[~g~E~w~] 以 $%{randomPrice} 出售 %{bags}x %{drugLabel} ? / [~g~G~w~] 拒絕報價",
        pick_up_button = "[~g~E~w~] 取貨",
        knock_button = "[~g~E~w~] 敲門",
        mystery_man_button = "[~g~E~w~] Buy / [~g~G~w~] Help your guy ($5000)",
        other_dealers_button = "[~g~E~w~] Buy / [~g~G~w~] 開始運毒",
        reviving_player = "Helping person back up...",
        dealer_name = "Dealer %{dealerName}",
        sending_delivery_email = "These are the products, I'll keep in touch through email",
        mystery_man_knock_message = "Hello my child, what can I do for you?",
        treated_fred_bad = "Unfortunately I don't do business anymore ... You should have treated me better",
        fred_knock_message = "Yo %{firstName}, what can I do for you?",
        no_one_home = "It looks like no one is home",
        delivery_info_email = "Here is all info about the delivery, <br>Items: <br> %{itemAmount}x %{itemLabel}<br><br> be on time",
        deliver_items_button = "[~g~E~w~] %{itemAmount}x %{itemLabel} deliver",
        delivering_products = "Delivering Products...",
        drug_deal_alert = "911: Drug Dealing",
        perfect_delivery = "You did good work, hope to see you again ;)<br><br>Greetings, %{dealerName}",
        bad_delivery = "I have received complaints about your delivery, don't let this happen again",
        late_delivery = "You weren't on time. Did you have more important things to do than business?",
        police_message_server = "A suspicious situation has been located at %{street}, possible drug deal",
        drug_deal = "Drug Dealing",
        newdealer_command_desc = "Place a dealer (Admin Only)",
        newdealer_command_help1_name = "name",
        newdealer_command_help1_help = "Dealer name",
        newdealer_command_help2_name = "min",
        newdealer_command_help2_help = "Minimum Time",
        newdealer_command_help3_name = "max",
        newdealer_command_help3_help = "Maximum Time",
        deletedealer_command_desc = "Delete a dealer (Admin Only)",
        deletedealer_command_help1_name = "name",
        deletedealer_command_help1_help = "Dealer name",
        dealers_command_desc = "View all dealers (Admin Only)",
        dealergoto_command_desc = "Teleport to a dealer (Admin Only)",
        dealergoto_command_help1_name = "name",
        dealergoto_command_help1_help = "Dealer name",
        list_dealers_title = "List of all dealers: ",
        list_dealers_name_prefix = "Name: "
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})