Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97415584CEB
	for <lists+linux-scsi@lfdr.de>; Fri, 29 Jul 2022 09:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiG2Hs4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 29 Jul 2022 03:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiG2Hsh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 29 Jul 2022 03:48:37 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CB080F6E
        for <linux-scsi@vger.kernel.org>; Fri, 29 Jul 2022 00:47:57 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31f41584236so43092267b3.5
        for <linux-scsi@vger.kernel.org>; Fri, 29 Jul 2022 00:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=raYxsRDeg0FNMRTafbd6anxlZF18WeZ0a4Kc2UicU8o=;
        b=VRuuCIw4wczqR6ceKHNEClafz4ENWNdRJW+JFLaRQG6ox5XkxzDgOtBtYaOeOs0iCv
         Ya2HeITSDrPHpihKVCFLb1k38JdTSMNRfj24526Qo4LN1Y5QXclCz9Int9WxwS+FsA+x
         NsjpYLUFS7cF3SzsndRol0qY3i/tEClSk+nPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=raYxsRDeg0FNMRTafbd6anxlZF18WeZ0a4Kc2UicU8o=;
        b=vpZN4IIthlrRTG5D9mB0IyIaL0NKH6rQAbhw+FxubhEfaSreGteef9P7LNoONNA7mZ
         YLFAt5pZUMqyii4suCmirE0HpYTQ4OFuGpsx49i9wUSW7Yx9wnePyRu7y32wfw0i33gO
         Wo7HUyIoyYiMKQapWy9tbKsLFxLk1sZO8MQM2KSY/xr0NVAaVxQfqV4IAFNcTZRLLVwL
         z0Qd1mEEeJH8lGwx2PD3QCYEkeyUWNuB2/tjJRMG6ZluaPqqvXizugX4uK4J9mu8WXfD
         ET8PATBLApLqXLK90KIETxRXVv+AeVeErCbmkUbNXHnTXDAb0my/I97S9lTESCQQ3pNy
         BocQ==
X-Gm-Message-State: ACgBeo3CcRhZtI3EXJc/m8tNk8M3L68Ar+JoBKmDg6++nW0wrbRQvXBL
        FivYP8kMeDqgAQQE9kTA8t3299SrJjAX3U8Qn5ling==
X-Google-Smtp-Source: AA6agR6tRTvHpDdb58tNLug1YBjGUweg50/uRVHyRxAOHyHI5lMiqY0Hx1kH7/OrX5vwByq6ixLPoaAzI5QCD4hFt+c=
X-Received: by 2002:a81:81c1:0:b0:31e:7378:960c with SMTP id
 r184-20020a8181c1000000b0031e7378960cmr2139816ywf.266.1659080877180; Fri, 29
 Jul 2022 00:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220729090521.v2.1.Id612b86fd30936dfd4c456b3341547c15cecf321@changeid>
 <3f96d798-e9bb-15d8-65b9-2383e112c654@acm.org> <YuOKNX4mWCb1LUrg@kroah.com>
In-Reply-To: <YuOKNX4mWCb1LUrg@kroah.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Fri, 29 Jul 2022 17:47:46 +1000
Message-ID: <CAONX=-eCX=n_JxHFTPHzLv+eaPpVs+Eqn+RF04FTdFgQzizC7w@mail.gmail.com>
Subject: Re: [PATCH v2] ufs: core: print capabilities in controller's sysfs node
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> Yeah, that's not ok, where are these bits coming from
There has been a few more iterations on the patch, in the latest state only
Clock Scaling and Write Booster are exposed as individual nodes.

> what userspace tools will be using them?
In ChromeOS we want to explicitly control WriteBooster state, but for that
the user space needs to know when it is supported but off, and when it is
not supported at all. On top of it, Clock Scaling complicates the story since
it disables the control via wb_on node. That is something I need to figure
out separately.

--Daniil
