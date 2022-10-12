Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02A25FBFE0
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Oct 2022 06:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJLE05 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Oct 2022 00:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJLE04 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 12 Oct 2022 00:26:56 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A642C6F55F
        for <linux-scsi@vger.kernel.org>; Tue, 11 Oct 2022 21:26:55 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a67so13484242edf.12
        for <linux-scsi@vger.kernel.org>; Tue, 11 Oct 2022 21:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ee1g+DQVjaU7Ixdagx5xQpa1KUPAjcmCcKTt3iTyQbc=;
        b=SD75wTWSax1S79K98ZcpgmbECwaG61EW44x2HI/HvJNbFtd726MznCJaQgLyqpQdf5
         IW4ta9PObvDJc/zqr8Umwkds524oBDopTUSWMzrG+N30veIdbPhkhkbTRvFJ5onsRrCF
         HrwAkEjxpOglbb55aIH091ClcMVLWFN5asHRJqw1/1PLXtb2nGOPMiCjzFNPQHjpTMEh
         MzNU7WDBzQ/KxJLBLUogPioAN7bP2khMXWPtJiahKc8+cevAJlD7VSjpBtv1kw8Xeawg
         YKzQEZxmJIjmPtfFV5ZIdU+Q7yVskfen1tzR4g1Cy7gt9lvHAlLBLHHbGCW1wRAcB9bG
         w2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ee1g+DQVjaU7Ixdagx5xQpa1KUPAjcmCcKTt3iTyQbc=;
        b=TGa8UU48elGthQuJWemK7IqI6C21OYGBO2ketlaI3VzPR4EtJXLOcmlx3VSlm004ZO
         FGl9gVNTz9+YxrM6sLAOyYmmNMhKqlKrYC7PoHSaCNFPzQFTCaluH0rXf0eAzq5X6HbR
         x9SE7a0AGu2oDAx/oD45raD7mlWb8Ex8MeGxpaCjjZPBMoqlRRHjOxs1I4OD44UTQ24O
         7nxh1p2mBwtc331mH3z+7jmR8wo9USpTh36k+TKM2J0BEnbiMpEdEDqzMIS78N/0qfqc
         76hbQYVmy9kEK9e+Awxm2nSWQtQDwYJSGDK1ouhpWa8IvRrEg/NOh5Dfru/t79H1KY4c
         MjBg==
X-Gm-Message-State: ACrzQf1WOikWFM2cmlcO6JzmippQPoAoDyurZda2/jYHbCpxfKaWMVfR
        yRvKh1EVXil+W6H6g5VlI8tz6Ww047XqmwXv1CY=
X-Google-Smtp-Source: AMsMyM4fVScjuWIKte9cOoCeaSZhLHNljD76B21OuKGEIP0UkKf+Sdl8aeFUxfeTrnoowpsEbTBmgIljzYAvU5gAbdk=
X-Received: by 2002:a05:6402:5c9:b0:446:fb0:56bb with SMTP id
 n9-20020a05640205c900b004460fb056bbmr26535963edx.173.1665548814084; Tue, 11
 Oct 2022 21:26:54 -0700 (PDT)
MIME-Version: 1.0
Sender: edwardjessica732@gmail.com
Received: by 2002:a05:6f02:804:b0:22:9d7b:cc29 with HTTP; Tue, 11 Oct 2022
 21:26:53 -0700 (PDT)
From:   Farida Hamed <faridahamed0010@gmail.com>
Date:   Tue, 11 Oct 2022 21:26:53 -0700
X-Google-Sender-Auth: 966Hjd9vJPNslPNCxnBp0TOpJ1c
Message-ID: <CADF_n_JMvwH4kYziXMT_wrxFfegSZrY1Zyb=_nB7mGe17b_5Mw@mail.gmail.com>
Subject: Hiiii
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

How are you and your family
