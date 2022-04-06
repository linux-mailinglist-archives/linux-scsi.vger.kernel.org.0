Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936374F6228
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Apr 2022 16:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbiDFOtK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Apr 2022 10:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiDFOtD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 6 Apr 2022 10:49:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F335E866B
        for <linux-scsi@vger.kernel.org>; Wed,  6 Apr 2022 04:21:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b24so2178727edu.10
        for <linux-scsi@vger.kernel.org>; Wed, 06 Apr 2022 04:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qoco3RRZczrBsbcgQAlfSk5MIz7VjrCwvzbtrToaDgc=;
        b=lYViyLKuxnmWvVOxSiIAvZo7ThzWayhTEithFwUkjoinkLc5FCaTrrYpbT4lWoKBwf
         SHgPUoZKJ7UV2IPYqxkuXYeeTYGRB83bdEMwIdBmZQKFxyDvfCEnlmoTCLT2OUjBdixY
         +G+SZiFdv3qepH4rdbFuW+L7cxBLBF32dysdgWgzwToIpOZTyeNLqWrZ4wQUZazH7P+G
         7hlLeTWPdexl+2Jz1SfDUOV3df8qLraggMceTQvB2595SmmUUQCz69mNwcRT30DswAW8
         p2g82mMXlYeye2LNaq72Bx0B1+oaVmBEYPJJneZtBT5wcJXOArVR1HP8KLHXNn2Q7dhs
         SQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qoco3RRZczrBsbcgQAlfSk5MIz7VjrCwvzbtrToaDgc=;
        b=5rNb0jnUw7foBpxeQlXli9apKvItMiYoKDWUTAkEVI2PPY1X3hxtssjjv5DZSTLajZ
         lzaAAlziwcu+QjEaW0OYYgm6RB5IkaZPFljGpjkbTLNH+AYI9yo8fErW9IVcfy0Ndasb
         kll/N/FUkk6m663LnEB2eRKsIphbNb6D19h5/Bgrm4OpKp6MCtsMPq4Bh9ap3AHTFBla
         gXc27cn396foRHhueJkzBw7/UTmnxOvWFKHWqDx5+j8IAlT1SjqMWoqzaHZAZu4Fwr98
         7EGNJnItXnRI/X//Q/NGBv+le/MfJcs04OOmVxFea4LaGeVCjZhhVMNS7bEj7mFy9mVq
         eInw==
X-Gm-Message-State: AOAM531042ShpTC2r9b8sDtSkHcV9MSFbdhBEMMp194yY9a9UbdzpKQe
        uO7x9kTVBFBkKIN+2+f8/Wbj4g==
X-Google-Smtp-Source: ABdhPJy6h64v3sKAn1fbVCaa1Z2Ysb9wdK3PGtCZ11UEJzUeLhJwFDk9MTZbEjA8xxN3l5Pyt59TpA==
X-Received: by 2002:a05:6402:430d:b0:419:45cd:7ab1 with SMTP id m13-20020a056402430d00b0041945cd7ab1mr8041132edc.367.1649244108812;
        Wed, 06 Apr 2022 04:21:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id og49-20020a1709071df100b006db0dcf673esm6505430ejc.27.2022.04.06.04.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 04:21:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 22DB51FFB7;
        Wed,  6 Apr 2022 12:21:47 +0100 (BST)
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
 <20220405093759.1126835-2-alex.bennee@linaro.org>
 <d01942c2-e600-b789-e613-9ead8c11d94a@acm.org>
User-agent: mu4e 1.7.12; emacs 28.1.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org, maxim.uvarov@linaro.org,
        joakim.bech@linaro.org, ulf.hansson@linaro.org,
        ilias.apalodimas@linaro.org, arnd@linaro.org,
        ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 1/4] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Date:   Wed, 06 Apr 2022 12:21:15 +0100
In-reply-to: <d01942c2-e600-b789-e613-9ead8c11d94a@acm.org>
Message-ID: <87ilrmjw38.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Bart Van Assche <bvanassche@acm.org> writes:

> On 4/5/22 02:37, Alex Benn=C3=A9e wrote:
>> +int rpmb_get_write_count(struct rpmb_dev *rdev, int len, u8 *request, i=
nt rlen, u8 *resp)
>> +{
>> +	int err;
>> +
>> +	if (!rdev)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&rdev->lock);
>> +	err =3D -EOPNOTSUPP;
>> +	if (rdev->ops && rdev->ops->get_write_count)
>> +		err =3D rdev->ops->get_write_count(rdev->dev.parent, rdev->target,
>> +						 len, request, rlen, resp);
>> +	mutex_unlock(&rdev->lock);
>> +
>> +	return err;
>> +}
>
> The names rpmb_get_write_count() and get_write_count() look confusing
> to me since these functions query the write counter. How about adding
> "er" at the end of both function names?
>
> Are there any plans to add an implementation of struct rpmb_ops for
> UFS devices?

Not by me but I agree it would be a useful exercise to see if a unified
API makes sense.

--=20
Alex Benn=C3=A9e
