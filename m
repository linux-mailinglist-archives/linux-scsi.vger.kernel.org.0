Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903ED5B799B
	for <lists+linux-scsi@lfdr.de>; Tue, 13 Sep 2022 20:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIMSak (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 13 Sep 2022 14:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiIMSaS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 13 Sep 2022 14:30:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03130A2622
        for <linux-scsi@vger.kernel.org>; Tue, 13 Sep 2022 10:46:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id 13so298790ejn.3
        for <linux-scsi@vger.kernel.org>; Tue, 13 Sep 2022 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=gVZ90l6hcWeze25kN56lqRugwkbWhkehnc8dJIxs+mpnPNawneCjeaXpb/44I3jldK
         25qOGSr2+mdHDEi7jWefjDLwYjwjZKxY3uC3AfhQjBr9yR8uq0tBS7pAjXLdeJ99o4j2
         YdS6kOYSUOv4qAIn0NyNGzkQE+UwQlCqKgSsZgyuNZG+fPVrL5D7kMBsw3GLK75Y+yDm
         krhBuiVf3gcpbBj3o5DyyIJsbimPOPJ1O0BebcK19gma0ApbIzEfD0jQLkdERmIHeXox
         2iJP0ppFrddC7+DN/n52u7LnrZhde+Mv/Ao3WTJ0L4bV0mnnibNRErhCopEgtwEWCepf
         FDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=cHxG46GXDWX84EjSsLZYzHSeJYSNURQJO7ggchEe2aNidwaCaG5owKWG/721avbGGP
         CrqhzcJKV69Ath1WKkP7g0T1fauOHqwxmVHZ2E+uYkxq0zPFgIFzGSZV49Am+m2M5HeF
         /dschAN/z28B3S8G5FacoiuH4lfoUmmQQirOOrjWquuOf6lGODeZzriVSzTlonbTuHx7
         AuyDMSqTFrYkmBgYqA2m53ph7WpIhIGUMscINuuN0f4BNot5jZREb9NIMaSGFe0dAqu+
         5icea2ENSfQml0BQuSxBAa81p10EP8hl0BtJlRot++DbUds3rJjXsQiispie520o9n+G
         8UWw==
X-Gm-Message-State: ACgBeo22qf/A3AUGK4QUBUKfFZwqE7P7V79OvJzfHL/wNsPPX0DUEIjD
        8EoHcMjJlBTEHgS2ekBY3wBvoeSdYeDHBxbAbWg=
X-Google-Smtp-Source: AA6agR6vVZ8pO2iqRBDOeRR2NMIjC9bFdiquZ5bXZrfL3y3E88+Orby6Opm30kg2VvVgKtiIajgy2z2JEdNMsA2RpZ8=
X-Received: by 2002:a17:906:cc0e:b0:77c:d77:576d with SMTP id
 ml14-20020a170906cc0e00b0077c0d77576dmr10075074ejb.658.1663091187609; Tue, 13
 Sep 2022 10:46:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:58c7:b0:6fe:9a00:633 with HTTP; Tue, 13 Sep 2022
 10:46:27 -0700 (PDT)
Reply-To: maryalbertt00045@gmail.com
From:   Mary Albert <mardiatidjani738@gmail.com>
Date:   Tue, 13 Sep 2022 18:46:27 +0100
Message-ID: <CAHR7mL5Zt8XxUi6VGKpUf3P5qzdjAXj6TV+m1qftGwfQ99kuAg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:632 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mardiatidjani738[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mardiatidjani738[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [maryalbertt00045[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
Hello,
how are you?
