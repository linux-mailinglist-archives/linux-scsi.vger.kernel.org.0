Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7016F5A5C
	for <lists+linux-scsi@lfdr.de>; Wed,  3 May 2023 16:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjECOrW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 3 May 2023 10:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjECOrW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 3 May 2023 10:47:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380CA5263;
        Wed,  3 May 2023 07:47:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4eff4ea8e39so6041993e87.1;
        Wed, 03 May 2023 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683125238; x=1685717238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3xAax5UMMKBBrbDbSmOKKPeFKZ83BBHuKP/eeSu5p4=;
        b=rkCbtRN1t07+/Mm/qp9LWT08mpQB23zqZwKxH/Jugd/NMBBtfp3x2iR88DiiT4MTau
         0hLjGt4gooDQzdKm/zMhrQOZmt3kYs5BJh/OpiH8gfeO9ZedFFpE6IQckWfdbSWH+MJf
         fa35lSUFY1CHzRfoZFZmGVxHsgF24HRkm69VfOYsOdnRxmJikPHeCfRHhZhTr+rHTGAd
         IrCrDkqqi/kFC+V4GhkpIEIMJiUr5KyQfTDoWnd4ATqB/+XK5Xf6u3dHkgW5FBnD2IDc
         FvfBa9HEGeJDQ1eu+X6q3cPFg1J0JDh1Jl85QNVwKUlnyJQl03KGvLy6eGElL8xrC0nD
         jvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683125238; x=1685717238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3xAax5UMMKBBrbDbSmOKKPeFKZ83BBHuKP/eeSu5p4=;
        b=J/dJjCD3h/BLw2MRnmNbWQrl2+sF9dgs/0Utvgdz0di2BwF0eaaDsJb60kJHb0xpqb
         OrRKG/LSY9XG1E7GN/ZkZ1fNT+fLYw79euX1hqQPVlskGWpGpmepqfgsW7iEuQSNwa9/
         0JywSuAxsCayIE2YJBWnapgvkn49VF8dF+SfiaTWZl6zo5WOum3N7+eUmAXztCbJVGq4
         rGnTRf6s2rxePC9O1Hr44j73Yu0CYAxQGDhoqlLADyqvgj1M4ZV9A4EbgG6UqmRDe2iI
         9ESkeIi437xSB7lLa/AkV3VTnljmy639kKV1LsVILBi5VN5OzlDVT+iqXRqS9MuaD1PU
         ypCA==
X-Gm-Message-State: AC+VfDwsOJXO9+ql1E8Xb8MWMxmySuX5wH1yExVdr6K9W9IjlegeCscS
        XUHrjgLenMCUiDWCJwx/y4uLbL8hb3xs9KWgag==
X-Google-Smtp-Source: ACHHUZ4wJk4FWZJ47z3eWowcIPsdV23tHhs0Q+a5X+3y6nD0P4oucFwMYwXky460hcvVU2vX04y8rfMGBaSfdbr64fM=
X-Received: by 2002:ac2:414a:0:b0:4ef:d41d:637 with SMTP id
 c10-20020ac2414a000000b004efd41d0637mr957607lfi.39.1683125238146; Wed, 03 May
 2023 07:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <68fce64f-4970-45f1-807e-6c0eecdfcdc2@kili.mountain>
In-Reply-To: <68fce64f-4970-45f1-807e-6c0eecdfcdc2@kili.mountain>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 3 May 2023 22:47:06 +0800
Message-ID: <CAGaU9a8eRPyMo9hUekiVL9ppZQspwsqk9RQTtmqHsTPBD7mcjA@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: ufs-mediatek: delete some dead code
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Teng <andy.teng@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Dan Carpenter <dan.carpenter@linaro.org> =E6=96=BC 2023=E5=B9=B45=E6=9C=883=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:41=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> There is already a test for "if (val =3D=3D state)" earlier so it's not
> possible here.  Delete the dead code.
>
> Fixes: 9006e3986f66 ("scsi: ufs-mediatek: Do not gate clocks if auto-hibe=
rn8 is not entered yet")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
