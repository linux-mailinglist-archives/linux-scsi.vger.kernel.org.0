Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781E15FFCC7
	for <lists+linux-scsi@lfdr.de>; Sun, 16 Oct 2022 02:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJPAiz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 15 Oct 2022 20:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJPAiy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 15 Oct 2022 20:38:54 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB803EA63
        for <linux-scsi@vger.kernel.org>; Sat, 15 Oct 2022 17:38:50 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id e22so3201612uar.5
        for <linux-scsi@vger.kernel.org>; Sat, 15 Oct 2022 17:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdnGpw3cfx5gw9ds81MMg2CAikH6ZcOgX7yFFUbe0+Q=;
        b=o3KRhyuhSifb2aqo375opscuxr+awx+o63X/5io26VmZ78Ow8fJeD5y0YOBCdJH9im
         KXvNFElQ5vhJZ63ru5FVlZpe1yvuQUOKYWVWg7DzENb4C/hgGTZurkqbdwK7pjSOlbIS
         BW7t1yPlrqVF1xYrhXJJ9GBD8wBp1q8bsjC3zcerxu3u56wmyIcb/Tzq6ibkhAg5dGNi
         N10XR/DZoDefe9lfXjpvAAArBnheYa/sykXKdL70vZEAeOmGoN4vPxBfPoNgUr3U/ayd
         Mjzb6rfH9UnCndJumlvSzUBlQaKNeTCJKKdNnpkM9WCMPelB/wwuoxe0Opyp8B1belpe
         lJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdnGpw3cfx5gw9ds81MMg2CAikH6ZcOgX7yFFUbe0+Q=;
        b=7Tc763T/ueAco/HecRGAH11PPMBrlPpNGZDi71BYG/R0fBQc+OFuxRtQkRcyLHhLnp
         khNBFk4CGIxtmQYxoVEWyciRob0i2CnrExtNURSsjUzlDI4MZpDHwWcw4d5stGz73GH0
         2VQtA+epecezrpSNGTqbkahu5TzWJd13lSF4t7dl3cW68FmDq0e5g5P7kTx42KLja3th
         bdOREXOXA1biCqkshvD0L0fX4n9qAtNnOePD3i+NmFPYs+3xtnKhWMFo5cXpUfOl9V6G
         /GBZcHVxBhggQ5wyqGX2rEdt8xXwMu2wQ3tn5OBM/tkqebSRpvZ6HLHnX+Pn0C5I8c5u
         9pyg==
X-Gm-Message-State: ACrzQf1Vf7uAd4oKLnbHRnAgfDtYmRC6bYb3yXHylCHX4i10l7+oV3+6
        z6isNDQ31T25qwm5X10j/URgW92M0CZjgEcQBfA=
X-Google-Smtp-Source: AMsMyM4RB4AiAFFkwB/hNTEHhfGyGu4yVlDXg/0LKyIc1uPyw1hWCu1h63HSORmYzQP5CIEzJMAgZ94QEHyBdotVCEs=
X-Received: by 2002:ab0:6cb0:0:b0:3d7:1184:847f with SMTP id
 j16-20020ab06cb0000000b003d71184847fmr1828660uaa.49.1665880728475; Sat, 15
 Oct 2022 17:38:48 -0700 (PDT)
MIME-Version: 1.0
Sender: jamilacompaore91@gmail.com
Received: by 2002:a67:1043:0:0:0:0:0 with HTTP; Sat, 15 Oct 2022 17:38:48
 -0700 (PDT)
From:   Hamza Kabore <mr.hamzak252@gmail.com>
Date:   Sat, 15 Oct 2022 17:38:48 -0700
X-Google-Sender-Auth: MU9tr4IKDi8H8pfjIJcRBIH_oOU
Message-ID: <CANeeueKrxRxUN-hG4UGN3DjG9PJWcJwHe1UhRHaHSDQTps_Z8Q@mail.gmail.com>
Subject: Urgent reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:92c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mr.hamzak252[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jamilacompaore91[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello, Good day!

I have access to very vital information that can be used to move a
huge amount of money($25.5m). I have done my homework very well and I
have the machinery in place to get it done since I'm still in active
service. If it was possible for me to do it alone I wouldn't have
bothered contacting you. Ultimately I need a honest foreigner to play
an important role in the completion of this business transaction. Send
your response to this email for further details as regards the deal.

Regards,
Hamza Kabore
