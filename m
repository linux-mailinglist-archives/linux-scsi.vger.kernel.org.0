Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F655E57AA
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Sep 2022 02:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIVAzd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Sep 2022 20:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIVAzb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 21 Sep 2022 20:55:31 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EEC89CC9
        for <linux-scsi@vger.kernel.org>; Wed, 21 Sep 2022 17:55:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id iw17so7361526plb.0
        for <linux-scsi@vger.kernel.org>; Wed, 21 Sep 2022 17:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=8rveiCO2s2ifRGP5UYnMLmArTRslMD6kGGFT4wMrtos=;
        b=pnQ0ZVXUSO1pmHdgcTc75xX2M5oRUfZQSNH6DGCfYFvWpjVScyu0MU4rkWUpkX5Xc5
         DzFEMSKGwpO+OdKzYMRBV0omGcCmzlD9CIwYn9tGJLVIcqdhP7noShMPZl6/zD7FTFlR
         0nw2MedS19DC+DfHnxA2Sd/fYJp/yRQPKld3ypLVvXkLIWI6L+pWIX/GOgF2IzAY8C3H
         HuQLLulzF+EcNQw7C6QlS+eTz/oS2WuZgZDSjn0vMWCwcWnkn2VQBUTA1o8wxwkE8/Cs
         sqXfnp0+gx3A2sO7KUdSUGHpibKVChN062giw2SvrjfAxCdz/iO3vefnwmuUQx/hd1in
         ZLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8rveiCO2s2ifRGP5UYnMLmArTRslMD6kGGFT4wMrtos=;
        b=gE3xMv5wad/PWDOmVNGyTSn698q4FW8vBSNwd1JTGAdAikJQ7qB1mgmwgemy5gsHrH
         W/jwas5OPsHDaHEbm60GT1RT9uY2FENkh5/7G+Dao+hxTE8b2vhZNYQzpFcA0nzdeq7J
         4CWWcfAjlAaPxYnqqDpXrs7GGCe+V5gH/i0U/FkvsMzbWpqtXTyLB/b9zdlQHGKLCT+c
         +n8nL77cZGnao3luM+55VUfssCmxCrMw7/jdgB/si+ISS03txpkJckt7NjxlvX1s6UY1
         NOSHuIv7awLYaEMSIJVvJSGVMgMXlZEaQXLfDLSh5HDzG7nJAcIyhDub+XQVcQx7AZLz
         ataQ==
X-Gm-Message-State: ACrzQf0VEnkM433dfHvJdbqcQ64Cv1TDjqFJ+1wLKQ8eRe3m3VO+/Zcb
        rrKQB9uaZ/nv98ADXyyv8oS4TGzEUch6A9pQ6No=
X-Google-Smtp-Source: AMsMyM4tIJ7I414SchQyW3J2DitG2ptgt06FSSjkif7p6oK7DVAfC5RtoXB08uCzVnM+PcJ08cyQKlllU9c6BANUx78=
X-Received: by 2002:a17:90a:2fc9:b0:202:5605:65ae with SMTP id
 n9-20020a17090a2fc900b00202560565aemr898187pjm.167.1663808125069; Wed, 21 Sep
 2022 17:55:25 -0700 (PDT)
MIME-Version: 1.0
Sender: otubarpavilion@gmail.com
Received: by 2002:a05:7022:e05:b0:45:5ad7:3a99 with HTTP; Wed, 21 Sep 2022
 17:55:24 -0700 (PDT)
From:   Pavillion Tchi <tchipavillion7@gmail.com>
Date:   Thu, 22 Sep 2022 00:55:24 +0000
X-Google-Sender-Auth: T-9R_ZMFUex3A0uuNekpL8-q1Q4
Message-ID: <CAFEQ9ba47kvrqCgCTX4F53LvX9U6X_ZXv0V-zsvaQDn+-r48QA@mail.gmail.com>
Subject: Inheritance
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_SCAM,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
Greeting
I wrote to you before, but you did not answer my mail.
How are you today and your family? I hope you are fine! With Due
respect, I am attorney Pavillion Tchi, I sent you a letter last month,
but you did not get back to me with response.& I have an important
information about your heritage worth $5.5 million, which has been
entrusted to you by your late cousin, from your country. I seek your
consent to present you as the next of kin for the claim of this fund,
because the bank has mandated me to present to them the next of kin to
enable them start the legal process for the transfer of this fund to
your bank account.

Your prompt response will be appreciated for more details.
Sincerely,
Pavillion Tchi
