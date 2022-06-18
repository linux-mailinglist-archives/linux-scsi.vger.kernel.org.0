Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58035506BF
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Jun 2022 23:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiFRVAY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 18 Jun 2022 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiFRVAX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 18 Jun 2022 17:00:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791F7B7CA
        for <linux-scsi@vger.kernel.org>; Sat, 18 Jun 2022 14:00:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k7so6598860plg.7
        for <linux-scsi@vger.kernel.org>; Sat, 18 Jun 2022 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xHkP1OXpqTGpMnl3S8KzBKz/x+0DBa4e/hpnPNs2B4Y=;
        b=REVvzCGiKIEVvk4+cZWRokvy1sp2PWlN2ceSL4fnA3ARgMAMjDk6YIFO5NlstDRBWs
         93+KsCOc3HNZHvcokJRwYgmixXWVczCgSDkGDK/5I+i9hZhcJh09hslFPx+6/tcH9Byy
         WWIVI2LkOxpDyWA+4p7Qsd1vMbr+SsuKvl64sxu1eUvVROggUN5Ge1UzzJhIulPT6MQq
         tX94sswVUlU1bhNZPjxEH76qwN+QJV4d7wWV+jHH9X3WGRLlZkA/uCdyMBue83hwR7EQ
         Zdc6jCfx9nJEVqMB3kuqVrP9kbYSpyQj0wm/c4YcxZFjFYHyjLVfYDmS3uCBeeNSPY2X
         wPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=xHkP1OXpqTGpMnl3S8KzBKz/x+0DBa4e/hpnPNs2B4Y=;
        b=3l833XNMC9qqFIlES1NUOGtGg4U7IsBqk0XY4PgB3OEsI3nJJaVaEtpz0zUzBGG9D7
         9S0OkzPbZtlQpMXJle9bl9OW3hoG6lRrz02Rz/ftkYg2ENLDSYqgt5Qgt1EB2C5UhNcD
         Eog+rjNN34cb8qNvYFRZlnKg2EJNlpsfhg1dYv4NX2Ju3VXWjpulOTM2FOnb1Uwj8nTP
         Kv/Wa+7DX8hEJpRHKL30BIy4nYd8Qlwr4hmnC6k0piS9AoUvK9kUgs+mc6Odo6CGWAHf
         eSFTA5SRqUw0sDTvuJdHQat+S4hy3IQipF9CIv96p9l2jByEjiY5XxqZoYB1blEh1UK3
         Gkhg==
X-Gm-Message-State: AJIora/KlDa+p29TWSj0Di04eUoUzLLUA2Pdgvmof94Qq7k306BbaNNE
        WYTaErVyfwHOriw1rsfTNVJdnCrs+/YxXqabwNQ=
X-Google-Smtp-Source: AGRyM1tGbsQAXCraSzNVrQ6U98rmnEHJGLyV+AeusIPpFG51xoKVeIPSPbxng+79YZx3Mj0gdIQqMHwZiK23Hi6R8+I=
X-Received: by 2002:a17:902:c2d5:b0:16a:1263:9313 with SMTP id
 c21-20020a170902c2d500b0016a12639313mr3541501pla.138.1655586019882; Sat, 18
 Jun 2022 14:00:19 -0700 (PDT)
MIME-Version: 1.0
Sender: zaring.kkipkalya@gmail.com
Received: by 2002:a05:7300:80c8:b0:66:6a95:2d24 with HTTP; Sat, 18 Jun 2022
 14:00:19 -0700 (PDT)
From:   Jackie Grayson <jackiegrayson08@gmail.com>
Date:   Sat, 18 Jun 2022 09:00:19 -1200
X-Google-Sender-Auth: VXphVZ8y9pESXdodmwDx5hG2xhE
Message-ID: <CANmOZ0wGzM2K=FdkrmnEpY9w9PgJh-FLez7OjsEH1=CTTjNa9Q@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Good Day Beloved

   This letter might be a surprise to you, But I believe that you will
be honest to fulfill my final wish. I bring peace and love to you. It
is by the grace of god, I had no choice than to do what is lawful and
right in the sight of God for eternal life and in the sight of man for
witness of god=E2=80=99s mercy and glory upon my life. My dear, I sent this
mail praying it will find you in a good condition, since I myself am
in a very critical health condition in which I sleep every night
without knowing if I may be alive to see the next day. I am Mrs,Jackie
Grayson, a widow suffering from a long time illness. I have some funds
I inherited from my late husband, the sum of ($11,500,000.00,)my
Doctor told me recently that I have serious sickness which is a cancer
problem. What disturbs me most is my stroke sickness. Having known my
condition, I decided to donate this fund to a good person that will
utilize it the way I am going to instruct herein.

I need a very honest and God fearing person who can claim this money
and use it for Charity works, for orphanages and gives justice and
help to the poor, needy and widows says The Lord." Jeremiah 22:15-16.=E2=80=
=9C
and also build schools for less privilege that will be named after my
late husband if possible and to promote the word of god and the effort
that the house of god is maintained. I do not want a situation where
this money will be used in an ungodly manner. That's why I'm making
this decision. I'm not afraid of death,so I know where I'm going. I
accept this decision because I do not have any child who will inherit
this money after I die. Please I want your sincere and urgent answer
to know if you will be able to execute this project, and I will give
you more information on how the fund will be transferred to your bank
account. May the grace, peace, love and the truth in the Word of god
be with you and all those that you love and  care for.

I am waiting for your reply.
May God Bless you,
Mrs.Jackie Grayson,
Written from the Hospital,
