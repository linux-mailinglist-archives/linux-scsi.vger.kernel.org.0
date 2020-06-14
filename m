Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D7E1F8881
	for <lists+linux-scsi@lfdr.de>; Sun, 14 Jun 2020 13:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgFNLCJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Sun, 14 Jun 2020 07:02:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40374 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNLCI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 14 Jun 2020 07:02:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id p18so9431687eds.7;
        Sun, 14 Jun 2020 04:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vAJP+Qm1ITbUQAx+Rf97o4j246jVO27jjV+OTrxlf9M=;
        b=KA6lNZSTuFKBkcG4HXnojDB4pAXB66TIOQzID8VKo3hgpFraw7eNN9P52FEe2RRihV
         IbfM59XkAiFw2MgNj1krHmhcCoSXjOfgHTAVeZjdc9J18wh7xL6DrSYtL8J9AB2VWZth
         YJllEjnNAJyAFh0xILyu17sRO83boxI91VKeQyQuDZCJaduRlSsPMYJsLzEwX1jqLrM4
         vpZxRniqXVtPu0FahwkgHwwbeynjRHS85RHJKr9LZXppmX9JekYtIea9ZrgG4sLBTKD6
         L6K7wOMba3uGiYKGXVmPwTNCqVasqz3ISj/3SQPE4X9TrHMRiBnwzdE0CoeVIZ4kGxqC
         qhEQ==
X-Gm-Message-State: AOAM532GDs028mokDblxB1iy0SatVPykiKaRfbPgD5hsdgnak4AkcpjR
        Cx5tS8cH8E6DwYzHpY8xMXc=
X-Google-Smtp-Source: ABdhPJwtSvwv9aaQuA4MA3Hl/WyWGidqaLZh3pPqB1mdV9/OfwZ6uDKB+wc1JMWBqtFyq3k9oCrZvw==
X-Received: by 2002:a05:6402:22a5:: with SMTP id cx5mr20312888edb.246.1592132525507;
        Sun, 14 Jun 2020 04:02:05 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id m30sm6507368eda.16.2020.06.14.04.02.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Jun 2020 04:02:04 -0700 (PDT)
Date:   Sun, 14 Jun 2020 13:02:02 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        linux-scsi@vger.kernel.org, avri.altman@wdc.com,
        martin.petersen@oracle.com, kwmad.kim@samsung.com,
        stanley.chu@mediatek.com, cang@codeaurora.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kishon@ti.com
Subject: Re: [RESEND PATCH v10 10/10] arm64: dts: Add node for ufs exynos7
Message-ID: <20200614110202.GA9009@kozik-lap>
References: <20200613024706.27975-1-alim.akhtar@samsung.com>
 <CGME20200613030458epcas5p3f9667bab202d99fb332d5bf5aad63c85@epcas5p3.samsung.com>
 <20200613024706.27975-11-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200613024706.27975-11-alim.akhtar@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Jun 13, 2020 at 08:17:06AM +0530, Alim Akhtar wrote:
> Adding dt node foe UFS and UFS-PHY for exynos7 SoC.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Tested-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  .../boot/dts/exynos/exynos7-espresso.dts      |  4 ++
>  arch/arm64/boot/dts/exynos/exynos7.dtsi       | 43 ++++++++++++++++++-
>  2 files changed, 45 insertions(+), 2 deletions(-)
> 

This is already applied and in the linux-next.  Don't resend applied
patches.

Best regards,
Krzysztof
