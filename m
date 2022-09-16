Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B905BB432
	for <lists+linux-scsi@lfdr.de>; Fri, 16 Sep 2022 23:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIPV6z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 16 Sep 2022 17:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiIPV6y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 16 Sep 2022 17:58:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3686BB91F
        for <linux-scsi@vger.kernel.org>; Fri, 16 Sep 2022 14:58:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id l10so22631156plb.10
        for <linux-scsi@vger.kernel.org>; Fri, 16 Sep 2022 14:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=worldwidemarketdata.com; s=google;
        h=importance:thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:to:from
         :from:to:cc:subject:date;
        bh=DUuJ2mgsOAAJCWASlsTejJyFk9U3fgBCbX5rANAlE+c=;
        b=aRrW0G1HU4K2Fa1aMYxo4ELtCriE2z47Lvl+4rG0yOnPe7kNpYsC0sYnTZa82ZaBnW
         goaGH5+msnqenlEA1qrAVStPtHm+FhE9+ZMM8hgYsAhB8Qc44vCdF406eOxONSWI57Dn
         2XKHIJZXljXJrGrdbEGNgVH9B0kS0jOin0/R8VvkodcW0X5cFcTUA+aHRxfpCqFL1AbY
         wAHy0x8ul4qWMSzU1awRdpHjEMailQ5Sk1RyxZYAJ3462RktRMGJHlqcrAv91E0BbZn8
         xBsLW8O8WLELjF6UpAM+Kwa39+XH5vVS9wRdNLoMyOcKGsNEsN5wpv9N+7ENywwH+jxi
         2D0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=importance:thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DUuJ2mgsOAAJCWASlsTejJyFk9U3fgBCbX5rANAlE+c=;
        b=P4ss1Kn1id0vt3OQxb6svrBKbgjKftowf7pEmrnu4viJ1O9ybmsmwLY6i/iUZpqYw1
         i7ojxVRxQ9KTrqYm+Ogn4/XPr/GldDAmBWvC3l/AlOgaIICPRPQT8cpH1VtQT4vtBKrh
         ntkzCU37pnW/ixfEZDC6m5H6dy0uCo7xU7GMlH/0Sq7nh3KxbOvXjewVBSbLNfmIVnJe
         cD0AgAtjhP8qz1udPNy4P4HpTNfubgW+1uSJO4xXZNlUIZzHOGeXXhDXrllEr+LMCzvA
         WTzEhlGRvLGIom5rkM6fkVdL5G0D+4wbXw8SwZZvasqvQCLwxR0O/d0a/wdAnJ0uz4Oy
         e86A==
X-Gm-Message-State: ACrzQf0zO4FRViFaOEE8vTFDMD7v4zbmpRuIe7GMOYWAT25idWbO14of
        wD/rxNfxL7JZauMZ6zdb2S6neA==
X-Google-Smtp-Source: AMsMyM7AmMLF+1VxEJ5YXKpWHIFW43eTF3cAw9YhsE6hFNmVESaHz9Enw4GFqeOaSA7e5ylIl68Bxw==
X-Received: by 2002:a17:902:7602:b0:172:a064:4a2f with SMTP id k2-20020a170902760200b00172a0644a2fmr1833956pll.56.1663365531358;
        Fri, 16 Sep 2022 14:58:51 -0700 (PDT)
Received: from DESKTOPR3SMN2M ([49.207.231.67])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e75200b0017849a2b56asm8967053plf.46.2022.09.16.14.58.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Sep 2022 14:58:50 -0700 (PDT)
From:   "Olivia Adam" <olivia@worldwidemarketdata.com>
To:     "'Olivia Adam'" <olivia@worldwidemarketdata.com>
References: 
In-Reply-To: 
Subject: RE: IBC Attendees Email List
Date:   Fri, 16 Sep 2022 16:53:24 -0500
Message-ID: <75c101d8ca17$80397f60$80ac7e20$@worldwidemarketdata.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook 14.0
Content-Language: en-us
Thread-Index: AdjKFbRgtn5b3SFKQ/2/HzocAapEcQAAMPMgAAAADxAAAAAKEAAAAAdwAAAACNAAAAAIoAAAAAhAAAAACNAAAAAIYAAAAAgAAAAACNAAAAAIYAAAAAgwAAAACPAAAAAJkAAAAAdgAAAADCAAAAALUAAAAAmwAAAACbAAAAAM4AAAAAmwAAAAC+AAAAAJcA==
Importance: High
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

I hope you're doing great and staying healthy!

Would you be interested in acquiring IBC Attendees Data List 2022?

List contains: Company Name, Contact Name, First Name, Middle Name, Last
Name, Title, Address, Street, City, Zip code, State, Country, Telephone,
Email address and more,

No of Contacts:- 35,028
Cost: $ 1,881

Looking forward for your response,

Kind Regards,
Olivia Adam
Marketing Coordinator


