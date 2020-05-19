Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7D81D90CD
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2020 09:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgESHQm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Tue, 19 May 2020 03:16:42 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:46976 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgESHQm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 19 May 2020 03:16:42 -0400
Received: by mail-ej1-f67.google.com with SMTP id e2so10866155eje.13;
        Tue, 19 May 2020 00:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=czw5XAHuVQyeo0GaaGsHjL+iNsEvTVJwYFnML7pk990=;
        b=g8Tl14Sniix92Mwgl3vIi4ITFl4rjPY31bEwq5NobtmN7+B9wrsCoew19K73VDXD76
         ++T63ZgEijGrvR0oYozjTtXSeYaq57c83D2Ef6P4StKBAnhGHfKUWUnmecVY3F8W2ZvO
         13z0u5KmQfFnnt1Xf9HcetHKFG0Nts0J2WhLzGeb49nzwW3gugm1/uqT4oDODxsRkTrl
         dTgjhRfSJCM1tnixGzSIib9vAHsIRMF7p8smOdRVbGsjjG5hqWmgBknHmZk6WFHYwrWX
         iKAtm7boPcm3D+UBiIGq1m1I88+1iUCwKU6Bp1BtS2EGuU02ek9PD8yR45Extib9Pwe6
         0Pdw==
X-Gm-Message-State: AOAM530dMzKdDX/M/7uKEKBgCdFmGrGwQe/P1sXLyDvgOHqwVQlkJT1T
        EmBQEOOwe4du3R9e7gvXRkg=
X-Google-Smtp-Source: ABdhPJzIRX+Uvac/mFboWQ4qXwL71U8FW6fLVGH+Y+7thPaQdu49D8AiTD5v1+LcEq4/Lq5C6URTog==
X-Received: by 2002:a17:906:3048:: with SMTP id d8mr18239949ejd.97.1589872599602;
        Tue, 19 May 2020 00:16:39 -0700 (PDT)
Received: from kozik-lap ([194.230.155.188])
        by smtp.googlemail.com with ESMTPSA id o21sm18954edr.68.2020.05.19.00.16.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 00:16:38 -0700 (PDT)
Date:   Tue, 19 May 2020 09:16:36 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        linux-scsi@vger.kernel.org, avri.altman@wdc.com,
        martin.petersen@oracle.com, kwmad.kim@samsung.com,
        stanley.chu@mediatek.com, cang@codeaurora.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 10/10] arm64: dts: Add node for ufs exynos7
Message-ID: <20200519071636.GA6971@kozik-lap>
References: <20200514003914.26052-1-alim.akhtar@samsung.com>
 <CGME20200514005313epcas5p3eac58d00d9f617b860a3ac607c8413ec@epcas5p3.samsung.com>
 <20200514003914.26052-11-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200514003914.26052-11-alim.akhtar@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, May 14, 2020 at 06:09:14AM +0530, Alim Akhtar wrote:
> Adding dt node foe UFS and UFS-PHY for exynos7 SoC.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Tested-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  .../boot/dts/exynos/exynos7-espresso.dts      |  4 ++
>  arch/arm64/boot/dts/exynos/exynos7.dtsi       | 43 ++++++++++++++++++-
>  2 files changed, 45 insertions(+), 2 deletions(-)

I will pick it up after all bindings get Rob's ack (or are picked up as
well).  The second bindings patch are still pending on that.

Best regards,
Krzysztof
