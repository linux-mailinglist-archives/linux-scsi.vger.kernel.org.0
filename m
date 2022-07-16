Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632EB576CA3
	for <lists+linux-scsi@lfdr.de>; Sat, 16 Jul 2022 10:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiGPIzF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 16 Jul 2022 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiGPIzF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 16 Jul 2022 04:55:05 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C36AB7F4
        for <linux-scsi@vger.kernel.org>; Sat, 16 Jul 2022 01:55:04 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w2so8007671ljj.7
        for <linux-scsi@vger.kernel.org>; Sat, 16 Jul 2022 01:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l9ZsNmk05iN6+VFZiJW7mW59na0Inh9htV4AahkyW44=;
        b=O6qTrNcYhgnYbToVlL95VE7ydGM3aYH/qK5DntO31xYbOHRp+QGMSSePhRDEMF8seF
         1oWhGvdv7UvPx2bqn2SbAHqO5RQpVbdN2qSNnx1uaVo0KP/good24OlENUMY5ursivvm
         Si9geZC7A05vxFW5CUBEI+Yrsdo/DkfKq/pbgJZJmzcZrs23aY3jGm2+Lp8NyD4EKjPJ
         TFMqWCQefjoDWdFjrD9R8GwnDQxAOLaVUEaSRwCeApDbrpzdVfvFuI9hy5B7OHk5D1Jm
         KH4hTz4CbY94hEc740GjeZ50aB0nCwham1NGN1M+LZyuderV9IDPeOx52rFQ1pPnssZs
         DUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9ZsNmk05iN6+VFZiJW7mW59na0Inh9htV4AahkyW44=;
        b=sMgBU38gHNs5w3kdeXg0u0JL1+puFOMghCB8Kyw41yo8ZQc1ZbmrSsbT4A/CXSo/A7
         04txDURHzWgH73aENlCJX7ln5MTFckOhlhIE8CCf8lQdNr9Sz/Ef+znaki9iKnpwPQrz
         8Jr11R4nqykDrnU+KOECbq99oanW9x4AvKPS02W9/I9JE28DxRe6RuBh34K5Zb8xP+hm
         dwovF8Piee2nfwsjc8rycECmAXZs+o3VBAh6K4YDSPN5t9dOARVzcurbpR0JGSId8NFZ
         ldqb1cx+XiMApXqHmFMIrTPxSHFrVhixz2/4PB9YS0g/jCpA5ANoVM9mFjNikOKww01o
         ZcrQ==
X-Gm-Message-State: AJIora8WZ5aLrqXyRyUfLWvkV6aPwOQzBezQFMMnFFzJGPECt7OkBukS
        UT5h53w3Uqn0ZGYqRTAAmWzRhNCoAhnjkxAa2Tt2g5ftCA==
X-Google-Smtp-Source: AGRyM1vOd3Hs1lrY7dgjKv2uCApIomptmRLtaW/ok/cyT6hlEki/DlTq1v2AWZpBrNvC07zziO1BeZgICzEw0pJMuYg=
X-Received: by 2002:a2e:9109:0:b0:25d:66fe:eda5 with SMTP id
 m9-20020a2e9109000000b0025d66feeda5mr8308424ljg.385.1657961702324; Sat, 16
 Jul 2022 01:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220715212515.347664-1-bvanassche@acm.org> <20220715212515.347664-2-bvanassche@acm.org>
In-Reply-To: <20220715212515.347664-2-bvanassche@acm.org>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Sat, 16 Jul 2022 16:54:50 +0800
Message-ID: <CAGaU9a9J7FBvLK+TKt2qPmVu1NRsT2bVOAaTWtHiym1O0se47g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] scsi: ufs: Reduce the clock scaling latency
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-scsi@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Jul 16, 2022 at 5:27 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> Wait at most 20 ms before rechecking the doorbells instead of waiting
> for a potentially long time between doorbell checks.

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
