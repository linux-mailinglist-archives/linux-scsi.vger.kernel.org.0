Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FB9588049
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Aug 2022 18:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiHBQbY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Aug 2022 12:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiHBQbX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 2 Aug 2022 12:31:23 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8F014D17
        for <linux-scsi@vger.kernel.org>; Tue,  2 Aug 2022 09:31:22 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p71so6105264yba.9
        for <linux-scsi@vger.kernel.org>; Tue, 02 Aug 2022 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=kzmbw3vvwR5BmAuxPNWxtLsP0MTPHz5k1iXNA7I9xMNwUYy3wPY4Ge/7NGkyiiSuHp
         t+PJiLOTYZIZGMFsv7MknSNtYEeJHgOlV69VLCb8Ka+dkQSOOCtIogXZxwOVhua/XbCt
         FNLlBF8loSUaft2WN8S6Ph1ax5OcVClo32PFzVlE3K9kKwAeDx+4y+oyEf9bKAvLsgj3
         ZvatXkhnnNuKzmOlqE+j75zZNuODLoCFxbV8DPIQZeOhDySpUWO9jgczDrhj7g8MWa04
         KHCfQymKRuEDs0UgIwFZINFkidQLdacl9Fjaoa5eG0fjKXh7uKtMV9WxrTrbp6LyGSf4
         TajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=XzXZR9ixAnjpdht4SGDvSsCYWuOAEcDtvsoWeFbZs/2b/fVjeLj538qLTFr/4Nsv4p
         SyEF96AehvjtnoYj1OCj/vXS4OcsrvbtrgxhNQu9g7y/vIozXzJYRte9QET+Ugfc0DO0
         fESwl/XWeG9KQa5HqCmbLRG0t+SrExyNLbhWSzYpqGEVLHJSFNfu3vv8U75kqCDFr8Xe
         THfNysrDLpnce3G3RyVTRslyFHb+roOOZ/lxxok27z+W99B7HEPXmh06AK2o5wCM7HL1
         MLeW1Td+Rpfh8ezMDD+CirkzIR9QwzCjn9DhFF3fejOb3ySwSvQl7kYjeevCF45zwk3S
         6P3w==
X-Gm-Message-State: ACgBeo23/otfTfXd2DTTe6Chb9+iHq3CbelG5EX90jc9mqwv6535/Oo1
        YOEnc0C/WcS8tNfAioQlYr7v79fgozV5BGa981o=
X-Google-Smtp-Source: AA6agR5SO8H+uhVWLgsNHH+45QgtOGeej+8NPTLxHlK488jgRe7MouPyLw0C7T856B02uLRvsPs+l8joMsxaMR9VOuM=
X-Received: by 2002:a5b:502:0:b0:66e:206d:15f6 with SMTP id
 o2-20020a5b0502000000b0066e206d15f6mr16347517ybp.160.1659457881793; Tue, 02
 Aug 2022 09:31:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:fa15:b0:2d0:6e96:7fe3 with HTTP; Tue, 2 Aug 2022
 09:31:21 -0700 (PDT)
Reply-To: lken58124@gmail.com
From:   Ken Lawson <pay2015mastergeneral@gmail.com>
Date:   Tue, 2 Aug 2022 16:31:21 +0000
Message-ID: <CAEnZB4=LF9_W_NneAUZa7UALvCu8JkHDebVwoL0Zie1B1xdngA@mail.gmail.com>
Subject: =?UTF-8?Q?Modtog_du_den_e=2Dmail=2C_jeg_sendte_til_dig_i_g=C3=A5r_morg?=
        =?UTF-8?Q?es?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


