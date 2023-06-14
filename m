Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C563F729178
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Jun 2023 09:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbjFIHrI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 9 Jun 2023 03:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbjFIHqr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 9 Jun 2023 03:46:47 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F7C1FEB
        for <linux-scsi@vger.kernel.org>; Fri,  9 Jun 2023 00:46:46 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-568af2f6454so13541857b3.1
        for <linux-scsi@vger.kernel.org>; Fri, 09 Jun 2023 00:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686296806; x=1688888806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQtWQgBWONEjapQJ3HGUtmOPuWCE3mcLvRmJpvrUrHg=;
        b=LyMadsitRIufLweIhTI+hPtNLXcZUNLMMWUpXLkmVpGQERt8m8BWk/xYROW/Yz4SSh
         yLhSmpswBZqLPw2ifCqYpm1xpAG+nGiuGDhyU96K9R/YOLIKKlgzcmvjBRXgE6nXsM5s
         pml3i9pM3Ea7m/7FrxdSID+R0SWKpWreU5JCivj/sTdQz8sd7UjQLR3eNdG2f0HAuYDL
         S5X5Q668T+HMmUwxhdL/h0uMTTNWFI7IsGlWrm8h2TzWEe8X7j4ytJODhZEsylAcFQDL
         8l48uf5UO5ZZxko8wHxh6GJ4LQProdR5JNOijtoAW+s5aJvgAHwuRaozSGDU8oJfmN+e
         m/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686296806; x=1688888806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQtWQgBWONEjapQJ3HGUtmOPuWCE3mcLvRmJpvrUrHg=;
        b=J7yyEPbHVaY6WKzGDIgADZ2opW6c+jD3OF7yAidcQi4Nu0jIfpLRm4qIAMT0TsnbLX
         LLi6vHfP7J798JIffKQS/SBdGVlgKhN4Hk9i5Jfx7o9t87dWZgDzwoabxcH6Xu0Bn7aO
         IiM5XcaGv7jEVCvu7R01CRd2OUZHR7oPxrCyAtoPGD//qrEXTak5rHONLklLA70uKQtA
         pDe8i/uMRPJBfjQkc8N3wBoLtjpoBMYA5/PPEfC62+pq5V1f4/SBQwxu4KB92tjRLezP
         k4xkY8LJstjIc1FHlJDbOMoKOkIoPIGrR24nm+84tkviq5ZoN78zZzvG1t+3NTt+gjtV
         TG0A==
X-Gm-Message-State: AC+VfDx1mDgKgrr8xiZz8oTZxnXpM+aPwqcgJmIxFi4kzQfJOg+Ng14n
        NvhNwHDz42fVc6/O5PyvYECvepNOkkDosxPW/hds5g==
X-Google-Smtp-Source: ACHHUZ55dnpCpQSf88QzN1dhH/frReaHdcdBTwnPH1jJ2/G1Jn6ipXKw/74xtImalulB9Gr93fuua0ElhWtX00WAt1U=
X-Received: by 2002:a25:a4a8:0:b0:bab:a56f:c580 with SMTP id
 g37-20020a25a4a8000000b00baba56fc580mr349340ybi.50.1686296806144; Fri, 09 Jun
 2023 00:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230608095556.124001-1-dlemoal@kernel.org>
In-Reply-To: <20230608095556.124001-1-dlemoal@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 09:46:35 +0200
Message-ID: <CACRpkdbmxoUwcwHdw4bcgaDy633ZKLOZ3z-d1qjzBF42omC1CA@mail.gmail.com>
Subject: Re: [PATCH RESEND] block: improve ioprio value validity checks
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jun 8, 2023 at 11:55=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org>=
 wrote:

> The introduction of the macro IOPRIO_PRIO_LEVEL() in commit
> eca2040972b4 ("scsi: block: ioprio: Clean up interface definition")
> results in an iopriority level to always be masked using the macro
> IOPRIO_LEVEL_MASK, and thus to the kernel always seeing an acceptable
> value for an I/O priority level when checked in ioprio_check_cap().
> Before this patch, this function would return an error for some (but not
> all) invalid values for a level valid range of [0..7].
>
> Restore and improve the detection of invalid priority levels by
> introducing the inline function ioprio_value() to check an ioprio class,
> level and hint value before combining these fields into a single value
> to be used with ioprio_set() or AIOs. If an invalid value for the class,
> level or hint of an ioprio is detected, ioprio_value() returns an ioprio
> using the class IOPRIO_CLASS_INVALID, indicating an invalid value and
> causing ioprio_check_cap() to return -EINVAL.
>
> Fixes: 6c913257226a ("scsi: block: Introduce ioprio hints")
> Fixes: eca2040972b4 ("scsi: block: ioprio: Clean up interface definition"=
)
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

This makes it easier to get things right.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
