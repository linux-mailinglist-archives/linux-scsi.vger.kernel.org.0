Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D6976787A
	for <lists+linux-scsi@lfdr.de>; Sat, 29 Jul 2023 00:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjG1W2D (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Jul 2023 18:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjG1W2C (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 28 Jul 2023 18:28:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E7044B9
        for <linux-scsi@vger.kernel.org>; Fri, 28 Jul 2023 15:27:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686f38692b3so2229215b3a.2
        for <linux-scsi@vger.kernel.org>; Fri, 28 Jul 2023 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690583276; x=1691188076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJmViVfbJZUOpaWkYQlb1HyRIrlESu4/YkhPXSNwKsQ=;
        b=McOZgZ74ohW0/ytI/ozqvAksmQPGak6eT0bnaaA5NqAyrw3LSSp0phNcnaFF/0Ah46
         QMZYwXCEpqAB62l5ILwh9muOvuGXO/H1d64CM3P2HxD5Mjjnk3i56zZYj6Zab1vRJ0yF
         4YCyVIiBTkbLvuFqbilhV4oFyeABU4gK89esU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690583276; x=1691188076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJmViVfbJZUOpaWkYQlb1HyRIrlESu4/YkhPXSNwKsQ=;
        b=Kj0SKppJYYJroqHlUbE3d9gpsJDXTgwxt/p4oITdlzQsEnQcrBlzkwUtLM8u9rn9yu
         rIBwzxvDNeTzx3dcMDABlu419OVYmaSwaFMJn/3HSkdQm0ROiK/KAOblMaSm30+FVY7U
         68roKPmoYlwRGuHWOGDkLmrete9W4ba0y5+EhrKvD2IXo3xiFl7RQG62gD8wfms9aYiW
         0Bf+Z0BuGUpItV1TxwlXPMPaPNXbsxxlESu9783viLoWnrzX8ub4meYheevXTUrNXqpO
         AOfYYiSERZEFHv//GhYWX60oZXpwK70k4w10SG+v6XwCLOuAuohkLXvmUn7aYhAqbHPO
         IHDQ==
X-Gm-Message-State: ABy/qLaQRw+b2c60YrZfhzeJJE6MA057g6JWWccglfjBC0CJcIV43aQI
        SdIW26i+F80HE0oLhOt/gXPWDA==
X-Google-Smtp-Source: APBJJlHHaeaPYUzn1UHI4kQ1cMg3BcZGonEinkrtEn+Ei6954g/2BpXZaVmrmzEY2GOJiqqmwbd0Zg==
X-Received: by 2002:a05:6a20:2c98:b0:137:8599:691e with SMTP id g24-20020a056a202c9800b001378599691emr3050596pzj.49.1690583276613;
        Fri, 28 Jul 2023 15:27:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n19-20020aa78a53000000b0064fde7ae1ffsm3647960pfa.38.2023.07.28.15.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:27:56 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:27:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Seo <james@equiv.tech>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] scsi: mpt3sas: Fix typo of "TRIGGER"
Message-ID: <202307281527.300679B747@keescook>
References: <20230725161331.27481-1-james@equiv.tech>
 <20230725161331.27481-6-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725161331.27481-6-james@equiv.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jul 25, 2023 at 09:13:30AM -0700, James Seo wrote:
> Change "TIGGER" to "TRIGGER" in struct names and typedefs.
> 
> Signed-off-by: James Seo <james@equiv.tech>

LoL. Yup.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
