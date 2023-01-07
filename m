Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5EE660B30
	for <lists+linux-scsi@lfdr.de>; Sat,  7 Jan 2023 02:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbjAGBDu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 6 Jan 2023 20:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjAGBDr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 6 Jan 2023 20:03:47 -0500
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4CF87913
        for <linux-scsi@vger.kernel.org>; Fri,  6 Jan 2023 17:03:44 -0800 (PST)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-1441d7d40c6so3400288fac.8
        for <linux-scsi@vger.kernel.org>; Fri, 06 Jan 2023 17:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C56Q+YV0i1VwzqpPgsaApjf/2tDIDNvnJyLhwVpmM08=;
        b=PliMBUjm1ruwn3JfN0zaC1Ras1YO8HWR6sJiD9bmZhbsyW7ZcgneLO11ksfnMp8iq6
         WOa+vuWs7RGDY+iC4AiE6PaFNQXBQqaBz4kHUQgbqidXJjp6sbrNKqeMrRc7olc7HpFi
         Jj2yP8ZRct3gAITMetYgsE64ENoqzRWJxl2jFDF4ygCnF5MXWuVXf9Sl/iqxFoxIbkVB
         FzzfjY2e9VgOs7zJzN1YUvL2hEsdK+dRNzb21jY35CI5ZNDuCFCrh6a35OkKaJM52jv5
         Jim6yuN+Tc3+6DhoTH5chF42GJa9hm4OYd0+l2K3u98DqvjBzqTeM2mNq6JXBPKi9c5O
         kTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C56Q+YV0i1VwzqpPgsaApjf/2tDIDNvnJyLhwVpmM08=;
        b=LYiL7S2f05OZq4BYze4cz/yHzarTzX+yLCvvv2zWFH98y5XA0f4X/5gKPpP19WvUva
         1q+Kem0FkbP2LVZXJu3pFspR5ciGrwEWtF0XatvOM2+T2f6Io7V9vEq1X3c1pMGQtrXN
         avlDa6EoK1HE0VMttBLhUQvVB7dQ5bz0URtYXphZQj9b2bzC2gOfvpt0FXsn3nWKTmOd
         lk2j+0B1TPc5U5e/dNJ1r33iHYXWXd2z/552DEOxLJ4eQwxIN8csUdKM6hUOIvL6Cln5
         N6aDSVMNm4a0bAsuImAGNo568ymyg1zAE2DeRj9Dg/StaCeFFP3MzNOC+fstA986PgYY
         k9yA==
X-Gm-Message-State: AFqh2kp+vZJ7rJgq/7U6rYXj+dsCKwxVUTXpDjrCLx/knm7vOW5JxSjw
        7id6tnlCMB/oGW3h0zKXO6BBxlz+rDJ35sHahuE=
X-Google-Smtp-Source: AMrXdXs6w9SQXoWcDm5jaqRP/R1f9pdIzSJumCWF2P6bma5tpAQ6LbizcSy0EQIU5MiAfXmEAG5absDnI9R120OQx0Y=
X-Received: by 2002:a05:6871:6c94:b0:150:8bf9:1c04 with SMTP id
 zj20-20020a0568716c9400b001508bf91c04mr1587440oab.239.1673053424007; Fri, 06
 Jan 2023 17:03:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6808:2387:0:0:0:0 with HTTP; Fri, 6 Jan 2023 17:03:43
 -0800 (PST)
Reply-To: jamesaissy13@gmail.com
From:   James AISSY <samueltia200@gmail.com>
Date:   Fri, 6 Jan 2023 17:03:43 -0800
Message-ID: <CAOD2y7k0FzOJ0e6QwELreGxC6WcxYUb61jyJX1FDtjTKSqVcOQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello My Dear,

I hope this message finds you in good Health.

My name is Mr. James AISSY. I am looking for a partner who is willing to
team up with me for potential investment opportunities. I shall provide the
FUND for the investment, and upon your acknowledgment of receiving this
Message I will therefore enlighten you with the Full Details of my
investment proposal.

I'm awaiting your Response.

My regards,
Mr. James AISSY.
