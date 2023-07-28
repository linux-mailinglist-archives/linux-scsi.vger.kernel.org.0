Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A3C767876
	for <lists+linux-scsi@lfdr.de>; Sat, 29 Jul 2023 00:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjG1W1C (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Jul 2023 18:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjG1W1A (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 28 Jul 2023 18:27:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EFC4498
        for <linux-scsi@vger.kernel.org>; Fri, 28 Jul 2023 15:26:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8ad356f03so16369255ad.1
        for <linux-scsi@vger.kernel.org>; Fri, 28 Jul 2023 15:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690583219; x=1691188019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HkSm+ndD6tws/M+8GeU3Zn68T+LSMkIKGnQAu8asx50=;
        b=eM2Svpxeoh46PSSVmzhwtznyRojBNSt8t5irD4p7FLDIct9aap/pt01MHJqojgA8IK
         dm4HKaywOLcV0yorVbH0+WhfOgHNbopdc5+LUTQwIaqzrCeSaUtL+S7HhzWCCCjUZY5n
         73Umc0UdP6Fwi8Xo7CQ+g6J2KLnq3MJCvZ3+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690583219; x=1691188019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkSm+ndD6tws/M+8GeU3Zn68T+LSMkIKGnQAu8asx50=;
        b=NTP48J/lZNzQEbhDFesdwghm0BPwn/QT7cKEFmzS+JX+25iedWQDXrxGusdr8mW4EP
         19EEnGheIKnH/Mt8I2AdW78mJh1RkRSBqAXmZORaRmOmFQ1KvJKIHuVhpUKKgTHBfByD
         L2Q9/AUnwdG/5+B+WqRU8bhiuimHwV8jgJQyPqltmZ2tX9Z8SWnpZhDo0rWFxcKC7V6w
         bDzJVE9AiLlhgiSpsVNupgdLyQWAfY9OP6t8PmLjn4cRXDhJb4HuYxhCk/mo52j4Ub1x
         01pvHAueIVDNMx2Av5A7kUM/XX2iMNP2J55sfJjjqGFsFJFrcQmDgoY/apxUD8GliW/B
         WPwQ==
X-Gm-Message-State: ABy/qLatGEv9p0RKRI5mJaQxFSrw7hm02wWA0Hsv3O67OiulaHM9lrfH
        DlIU3428mbo9VFsLs6Lt2XBeqA==
X-Google-Smtp-Source: APBJJlGDxf4vVh0HVQVjFrwx+cVrgt1i5RmP5vwK3Jp1x0xx7YUqaH5iMnsAQvzB2QWieFw3DdqysQ==
X-Received: by 2002:a17:902:9a87:b0:1b9:dea2:800f with SMTP id w7-20020a1709029a8700b001b9dea2800fmr2482929plp.8.1690583219230;
        Fri, 28 Jul 2023 15:26:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b001b7f40a8959sm4075800plg.76.2023.07.28.15.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:26:58 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:26:57 -0700
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
Subject: Re: [PATCH 2/6] scsi: mpt3sas: Use flexible arrays when less
 obviously possible
Message-ID: <202307281508.32604C856@keescook>
References: <20230725161331.27481-1-james@equiv.tech>
 <20230725161331.27481-3-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725161331.27481-3-james@equiv.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jul 25, 2023 at 09:13:27AM -0700, James Seo wrote:
> These old-style 1-length variable arrays can be directly converted
> into C99 flexible array members without any further source changes
> and without any meaningful binary changes. All uses of the affected
> structs were investigated, and the existing code somehow manages to
> weather the reduced sizeof() the affected structs in every case.

Doing build comparisons here, I see a lot of binary changes. They may
be, as you say, harmless, and since you've actually got hardware then
this is a good verification of the changes, but I do wonder if this
needs more detailed commit log (or split up patches).

However, the problem I see is that this code was already doing weird
stuff with structs that appear to not have been using flex arrays
actually. With "pahole" I can see struct MPT3SAS_ADAPTER changes:

-       Mpi2IOUnitPage8_t          iounit_pg8;           /*  3668    40 */
-       Mpi2IOCPage1_t             ioc_pg1_copy;         /*  3708    24 */
+       Mpi2IOUnitPage8_t          iounit_pg8;           /*  3668    16 */
+       Mpi2IOCPage1_t             ioc_pg1_copy;         /*  3684    24 */

struct _MPI2_CONFIG_PAGE_IO_UNIT_8 (Mpi2IOUnitPage8_t) is in the
_middle_ of struct MPT3SAS_ADAPTER.... :|

In the earlier attempts at this conversion, it seemed that some of these
are actually fixed-size:

https://lore.kernel.org/lkml/20210202235118.GA314410@embeddedor/

I think this patch needs to be broken up into per-struct changes, so
they can be reviewed individually.

-Kees

-- 
Kees Cook
