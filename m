Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F63704A05
	for <lists+linux-scsi@lfdr.de>; Tue, 16 May 2023 12:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjEPKGu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 May 2023 06:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjEPKGt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 16 May 2023 06:06:49 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF3D19B4
        for <linux-scsi@vger.kernel.org>; Tue, 16 May 2023 03:06:45 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-77d50a1c8deso4146011241.3
        for <linux-scsi@vger.kernel.org>; Tue, 16 May 2023 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684231605; x=1686823605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJ5WDN3DjxlHoC+PKB9u34xmvDgAcgwNKb6XXaL35hE=;
        b=Ay2WSygufTNGqJabs/hjybJoiCVEv5RB7deFGPO2wuiw82jcAjVGUPAk7ujp74Cuwu
         zPXb72C8QBKF6Z3bSsQpMYRTjwdtJ+jE1UNHEWSZUewTFbOXNqz9T8RmhhQ1RA948NTi
         5GvtNQaSjGhivq/iCXdWUD1gIWv5ptIbZ5juMHuSYaMHMVf1425SHrm7sFVnRpyeFJ0o
         toJIl/DVnGigxkUyyN076kaX+jqR5MjeCpcrE1kdrI8I/himhE/tgyxC3g9+6UdMl3BZ
         0npZtA+DUJoELA8vd1lEIwieaoV+WP/feF++QWavd6HdEp55kVcfjGX+ry4DbheKCLtT
         I47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684231605; x=1686823605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJ5WDN3DjxlHoC+PKB9u34xmvDgAcgwNKb6XXaL35hE=;
        b=PKfk8J8P+bqRE6RBKIRvz+8MhmLXtxbuGkhV0U+y2qRzh1WuBsNty/wUbBVPQIyuQW
         w565yybp7upkvBcx24bEtw4ARgEXCWvVcJ721F3AWSQkX9PTAul4yVaeCZfhP8pelG8J
         ay4m7H4hlNKPXlY/PWV0GoHhwRs5WJQyD4x6lKILZr6qDevknVSReQNAjxftayr/moGC
         MiyqTGpmpY1KZG4pi0tG90BGnbmKXqcVZJqQnptMeIEG4BRHC75/pRHRGVvWvoag2DYy
         iHge+OR3FUVldpBtLv8eCYR+IwVYbdKdesCkc7xmoAbdjvGqdmDH2UQ0CEB9QMdbNfJh
         US+A==
X-Gm-Message-State: AC+VfDypAqeC250pUEXMC+M1a6xDJW/Gl1tIyJpBXFaI/Gus2Is8Yh7B
        IjEO2oawQldTCjS1LCPZXZK6Gfc0TamkomIjYNCGKA==
X-Google-Smtp-Source: ACHHUZ40MVTgx2lo2t3GLhWu3fMQszo4IcN1i2bu2E0cau1DdmwzovAd8/IssRIkFf3sD6YNFEWt3bJl0EHQ5B+V28M=
X-Received: by 2002:a05:6102:534:b0:42e:3b16:8695 with SMTP id
 m20-20020a056102053400b0042e3b168695mr14042762vsa.3.1684231604875; Tue, 16
 May 2023 03:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230411130446.401440-1-brgl@bgdev.pl> <20230411130446.401440-2-brgl@bgdev.pl>
In-Reply-To: <20230411130446.401440-2-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 16 May 2023 12:06:34 +0200
Message-ID: <CAMRc=MdDct0UzJPpOTuKHmm23Jc529NwkBWJJmXfeevpkQaSxQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: ufs: qcom: add compatible for sa8775p
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Apr 11, 2023 at 3:04=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Add the compatible string for the UFS on sa8775p platforms.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Docume=
ntation/devicetree/bindings/ufs/qcom,ufs.yaml
> index c5a06c048389..b1c00424c2b0 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -26,6 +26,7 @@ properties:
>            - qcom,msm8994-ufshc
>            - qcom,msm8996-ufshc
>            - qcom,msm8998-ufshc
> +          - qcom,sa8775p-ufshc
>            - qcom,sc8280xp-ufshc
>            - qcom,sdm845-ufshc
>            - qcom,sm6350-ufshc
> @@ -105,6 +106,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,msm8998-ufshc
> +              - qcom,sa8775p-ufshc
>                - qcom,sc8280xp-ufshc
>                - qcom,sm8250-ufshc
>                - qcom,sm8350-ufshc
> --
> 2.37.2
>

Bjorn,

Are you picking this one up as well or should it go through Rob's tree?

Bart
