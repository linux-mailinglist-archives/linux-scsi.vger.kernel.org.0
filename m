Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEB322BB0
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 08:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfETGBf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 02:01:35 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:13920 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbfETGBe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 02:01:34 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190520060130epoutp0389e1f5540969bbc3303bc8ed58c18e55~gTsetVYUK0262502625epoutp03s
        for <linux-scsi@vger.kernel.org>; Mon, 20 May 2019 06:01:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190520060130epoutp0389e1f5540969bbc3303bc8ed58c18e55~gTsetVYUK0262502625epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558332090;
        bh=ZlIRUVlmGQZbrFA2K849hMAvwE5CY6Go+SGQFATcamY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=uB+OpbFm/uqpRurry6YEPfL70ogUIjDiFJjd2XYqnWnsKUpKBKTA0UF8jTtEBFXqq
         8+oHkmvSZu0jL47QkojIhnrqKBAa0/d5qR87agT5wGkJaxNzUibz+/WvxZtA9DvD6S
         dZmgTLjVFqjg/dJgrxCQi03YPIV2ghOQkD8sLwj4=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20190520060130epcas5p4dfc62205ca4ac9bb16f95e7689e27a20~gTseMpIbY0445404454epcas5p4H;
        Mon, 20 May 2019 06:01:30 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.12.04067.9B242EC5; Mon, 20 May 2019 15:01:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20190520060129epcas5p41c2c72654d3036bb3fda4bbe19bac7cc~gTsd2d3VY0445404454epcas5p4G;
        Mon, 20 May 2019 06:01:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190520060129epsmtrp29d1cd98c1520dd0ae4e6a6086a21a83b~gTsd1gMs11623216232epsmtrp2k;
        Mon, 20 May 2019 06:01:29 +0000 (GMT)
X-AuditID: b6c32a4b-78bff70000000fe3-9c-5ce242b9b4d3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.7D.03662.9B242EC5; Mon, 20 May 2019 15:01:29 +0900 (KST)
Received: from [107.108.73.28] (unknown [107.108.73.28]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190520060127epsmtip2807d02786cadb233f2b6289a5e3ef8c4~gTsbyGDWQ1714917149epsmtip2H;
        Mon, 20 May 2019 06:01:27 +0000 (GMT)
Subject: Re: [PATCH v2 3/3] scsi: ufs: Use re-factored Auto-Hibernate
 function
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, avri.altman@wdc.com,
        pedrom.sousa@synopsys.com
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        evgreen@chromium.org, beanhuo@micron.com, marc.w.gonzalez@free.fr,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com
From:   Alim Akhtar <alim.akhtar@samsung.com>
Message-ID: <434c1d39-943d-a05b-5366-dddf3064f180@samsung.com>
Date:   Mon, 20 May 2019 11:11:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557912988-26758-4-git-send-email-stanley.chu@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+XYuOy5Xp2X1NqNiEHZTExNO0Y3ojxOF+UdkyFBHHpY459i0
        7EKOXKUuMS1azqgVWmKisZyVKU6LhVQDqRlaY5iXaHnJrYvpzNqOkf/9nu99nu/l+fgoTDJC
        SKlMdS6nVStUMlKENz9bvy76yZ6P8s2++9uYlzddGPP5l4tkOvqLcaZu5DHJnPeYBMz5WS/G
        WAd6COZNYTdijO/+Dpr9rzHm3ovfAuacIZ4xOL7jjM03TTA1tl60exFbpe/G2bIGP8E+MbuF
        7MPqAtbQ1Y6zPxuLSHZiqA9nm9r9iPVbV7EX7UZBkihFtD2DU2Ue57SxO9NFx2Y8PkwzROXb
        qn2kHpmFJYiigN4CRZ7VJUhESeinCAYsPRgvfAhmncU4L34g6PowTpagsFCiw1Ys5AdtCGZG
        TYgXowgqpiaIoGsJnQReQ23orgj6KoLx37aQwOhrAphoeY8HXSS9EdymJkGQxfROsE3psSDj
        9Foo95aFeCl9BDyOBwTvWQxdlYOhbBi9D0pvV4bOMXo59A3eEvC8Gh6N3ggtA7pFCI5Lboyv
        uheavgr5DkvA+6JpjqXgH2sjeUsWXGqJ54/PQM1NB87zLrC/vYEHLRi9HhpbYvlNC6F0elDA
        J8VQdEHCu9dC4ZhrLhkJ5UYjwTMLztqGued9j+D6dIC4jNaY5xUzzytjnlfG/H+zBeF1aAWn
        0WUrOV2CJl7NnYjRKbJ1eWplzNGcbCsK/cEN+x8jq/NAJ6IpJAsXs6Z+uYRQHNedzO5EQGGy
        CHF8lEcuEWcoTp7itDlp2jwVp+tEkRQuWy6uIFxyCa1U5HJZHKfhtP+mAipMqkepcpFyOFDQ
        7X5Z7K6ypUvPnu7MquyW78itX3BB5chN3qrSG6ISzU7LXbTneiTpapXOJDo2hcs+tk6+svcN
        hdudpyzUyPOqFOJQqsTZlcjtyh9Oizbdi+tVBD4tzQwc9Oud9l5DZbtyJZZwuD7ZWqce1pSm
        Dn27smyyIP/OFxmuO6aI24BpdYo/Q7OPVH8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCSvO5Op0cxBrsOKlmcnneV2eLlz6ts
        FgcfdrJYrHqzg82i9f50JovW/6+YLTY9vsZqcbn5IqNF93WgxLbPZ5ktlh//x2TR1GJs0XLs
        K4vF1k+/WS2Wbr3J6MDvMbvhIotH/7rPrB47Z91l99i8pN6j5eR+Fo/v6zvYPD4+vcXisWX/
        Z0aPz5vkPNoPdDMFcEVx2aSk5mSWpRbp2yVwZfy9/4m54ClHxdYln9gaGGexdzFyckgImEgc
        3NoJZHNxCAnsZpS4eW4RM0RCWuL6xglQRcISK/89hyp6zSix930PK0hCWMBPYtvXh2AJEYEp
        QIlVD5lAHGaBKUwSG59vYIZouc0osa+hDWwWm4C2xN3pW5hAbF4BO4mtvxrA9rEIqEpMfNUP
        ZosKREiceb+CBaJGUOLkzCdgNqeAp0Tvwplgq5kFzCTmbX7IDGGLS9x6Mp8JwpaX2P52DvME
        RqFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgmNXS2sH
        44kT8YcYBTgYlXh4PaY/jBFiTSwrrsw9xCjBwawkwmusfj9GiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOK98/rFIIYH0xJLU7NTUgtQimCwTB6dUA6P600WJp5RbdjzxPSOd/pKruU87sP6Kjrni
        5acygpuuHlN8b9ezdnv/XYadQib6/gcrEx4te8qkff625Pfsxg3r/RJ60+KFJUSWenMuSL98
        t3H3yeNc/P5rze5YKag9+DXbsn1bl/utnI0a/yU0dPgs7e8qvG3MLNnG9mr1cT72xUzRN2c0
        uSuxFGckGmoxFxUnAgB8WoM32QIAAA==
X-CMS-MailID: 20190520060129epcas5p41c2c72654d3036bb3fda4bbe19bac7cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190515093949epcas1p12036c690c89a9396545f4776dcf42e69
References: <1557912988-26758-1-git-send-email-stanley.chu@mediatek.com>
        <CGME20190515093949epcas1p12036c690c89a9396545f4776dcf42e69@epcas1p1.samsung.com>
        <1557912988-26758-4-git-send-email-stanley.chu@mediatek.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 5/15/19 3:06 PM, Stanley Chu wrote:
> Use re-factored ufshcd_is_auto_hibern8_supported() function
> in ufshcd_init() instead to make code more cleaner.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>   drivers/scsi/ufs/ufshcd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index e6a86223a0d4..17af157c2cc1 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -8340,7 +8340,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
>   						UIC_LINK_HIBERN8_STATE);
>   
>   	/* Set the default auto-hiberate idle timer value to 150 ms */
> -	if (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT & !hba->ahit) {
> +	if (ufshcd_is_auto_hibern8_supported(hba) & !hba->ahit) {
After fixing the typo in above line (as pointed by Avri in patch 1), 
feel free to add
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
>   		hba->ahit = FIELD_PREP(UFSHCI_AHIBERN8_TIMER_MASK, 150) |
>   			    FIELD_PREP(UFSHCI_AHIBERN8_SCALE_MASK, 3);
>   	}
> 
