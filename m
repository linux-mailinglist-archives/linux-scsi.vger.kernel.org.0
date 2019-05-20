Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC80B22B1C
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 07:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbfETFZy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 01:25:54 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:62906 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729967AbfETFZy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 01:25:54 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190520052550epoutp04bdac4e8301682a4129c9e8c6db0f8787~gTNVvunlu1727617276epoutp04L
        for <linux-scsi@vger.kernel.org>; Mon, 20 May 2019 05:25:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190520052550epoutp04bdac4e8301682a4129c9e8c6db0f8787~gTNVvunlu1727617276epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558329950;
        bh=VYqZ8pX4JEj6SMX7HVs1dhhu8H1gxzZkoe1GrhwI4Zo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PHV+uTDQojxQYCsbliGOo5XVYpfkq7hMwn8YUUBDAVrAEI+ZZxf48+CsxlvzvOQ9G
         zieLyMANFeU8BGMI97a5mebOaQkAbTfRKIGHVuDiuRNEAot+e2icdPgX6aEf48thRz
         3pxttnAaIUm+0oVn3snMew61qDdAYvd1AHsGq0Rc=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20190520052549epcas5p391a70df588f08d6bfd0268091d3097e3~gTNVE-zLy0368503685epcas5p3d;
        Mon, 20 May 2019 05:25:49 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.99.04066.D5A32EC5; Mon, 20 May 2019 14:25:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20190520052549epcas5p31f79f15fd71cbb13bfdfacdd5be2b3b9~gTNUvl6gq0368903689epcas5p3T;
        Mon, 20 May 2019 05:25:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190520052549epsmtrp2bff5e032b66ce571f2d433707371f609~gTNUukvno0347903479epsmtrp2f;
        Mon, 20 May 2019 05:25:49 +0000 (GMT)
X-AuditID: b6c32a4a-973ff70000000fe2-d4-5ce23a5d1f12
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.0E.03692.D5A32EC5; Mon, 20 May 2019 14:25:49 +0900 (KST)
Received: from [107.108.73.28] (unknown [107.108.73.28]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190520052547epsmtip2425e9597cbcbc3914b3e5ec1b18b1a3a~gTNSoWB-03166531665epsmtip2U;
        Mon, 20 May 2019 05:25:47 +0000 (GMT)
Subject: Re: [PATCH v2 1/3] scsi: ufs: Do not overwrite Auto-Hibernate timer
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, avri.altman@wdc.com,
        pedrom.sousa@synopsys.com
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        evgreen@chromium.org, beanhuo@micron.com, marc.w.gonzalez@free.fr,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com
From:   Alim Akhtar <alim.akhtar@samsung.com>
Message-ID: <15a271c6-88c8-b9d5-68a8-dc142afdf224@samsung.com>
Date:   Mon, 20 May 2019 10:35:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557912988-26758-2-git-send-email-stanley.chu@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0gTcRznt7ub52h2TcNvCrUmIhpqZdn1wAp6XCEUZhCxqJWXis7Gppa2
        Smw+aj3UJHXqelohlOI7S8tVyjDDVSrO1moZ0Uh7TIswsm23yv8+T37fD/xITGQnAsjktHRW
        mSZLlfAFeMuj0LDwPats0sWNz6PpXv0ARn/8OcCnu96ewunaT218Os9axqPzpu0Y3fBukKBf
        nDQhWjvkNFocfRh9s+c3j87VRNGa7kmcbv42RdA1zcNo3WymMseEM+fvOAjmrs7ixTReP8Fo
        jA9w5kddIZ/5+t6MM00PHIhxNMxnCh5qedsFuwVrEtjU5ExWGRmzT5BUNilWvCaPlNh+ETmo
        2Os08iaBWgbT08NOLCBF1D0Etg9nPOQbAnt/qYd8R/BZe/tfpVr/E+eMDgSPx98gjowhaO08
        y3elfKlYGB7S812GH1XqrP9uxlwEoy7y4Gv7CO5K8alFYClr4rmwkIqB5/kGt45TwaDtqHPj
        udQusHbXE1xmDhgrRt26N7UFvvRp3DpG+YN59BKPwwugdawK427t9AJd4zIOb4CnfUbPBl+w
        9zR5cAA4xjucl5JOnAJn2qM4WQ01+m6cw2vh4csq3BXBqFCoa4/kXvKBs1OjPK4phMJ8EZcO
        hpPjA55mIBRrtQQXYaCgAFyyiBpBUKRZW4TEuhmzdDOm6GZM0f1/9zLCa9E8VqGSJ7Kq5Yql
        aezhCJVMrspIS4w4cEjegNw/MGxrG7rxLNaAKBJJZgm/lL6VighZpipLbkBAYhI/YVSIVSoS
        Jsiyslnlob3KjFRWZUCBJC7xF5YQA1IRlShLZ1NYVsEq/7o80jsgBy2MNmZc9bb9mDDwyTiz
        T9vS+mh1lzXotXgwP2jHytQVCcadleyENbMk3HLhWO8Tu19j/NDg2C317KL44+JyTah806uW
        1vLl+5MqzHEbTd/vHlHXdt7KnjBFKi3WTYW5/tXXHL1NVNeI8nr66oNV4nMlMduubF7/0p5w
        /+iLGtQfIsFVSbIlYZhSJfsDt5XHPX0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWy7bCSvG6s1aMYg7NTpS1Oz7vKbPHy51U2
        i4MPO1ksVr3ZwWbRen86k0Xr/1fMFpseX2O1uNx8kdGi+zpQYtvns8wWy4//Y7JoajG2aDn2
        lcVi66ffrBZLt95kdOD3mN1wkcWjf91nVo+ds+6ye2xeUu/RcnI/i8f39R1sHh+f3mLx2LL/
        M6PH501yHu0HupkCuKK4bFJSczLLUov07RK4MqZ/VSi4x1Ex6dEf1gbGiexdjJwcEgImEnPn
        /WTpYuTiEBLYzSjx984iNoiEtMT1jROgioQlVv57zg5R9JpRYlL3GVaQhLCAj8TN6/PYQBIi
        AlMYJfauesgE4jALTGGS2Ph8AzNEy21GiaazE8Fa2AS0Je5O38IEYvMK2ElcajvEAmKzCKhK
        dO9dD2aLCkRInHm/ggWiRlDi5MwnYDangKfEh7MtYHOYBcwk5m1+yAxhi0vcejKfCcKWl9j+
        dg7zBEahWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYIj
        V0tzB+PlJfGHGAU4GJV4eD2mP4wRYk0sK67MPcQowcGsJMJrrH4/Rog3JbGyKrUoP76oNCe1
        +BCjNAeLkjjv07xjkUIC6YklqdmpqQWpRTBZJg5OqQZGr6RJYe8SX2d9+rb014z4c1Y3W+3P
        cK1sNY02V4m17JnW3nigoSFUU9D3YgZD6fZlZwxL/VPdTjv+S39zwHZa78LTV7TN3wX3fZ52
        JKeZcw6rxmq9Y4c+X2H/nnY/12PNQpOLXvPYX7btL9g7I0x21b3iSxPsyxUe8bp92T4t+6O8
        nLrUxqnJSizFGYmGWsxFxYkA46CZWdgCAAA=
X-CMS-MailID: 20190520052549epcas5p31f79f15fd71cbb13bfdfacdd5be2b3b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190515093640epcas2p17e4c3e4545ce5e4e4b59ed7b9a954741
References: <1557912988-26758-1-git-send-email-stanley.chu@mediatek.com>
        <CGME20190515093640epcas2p17e4c3e4545ce5e4e4b59ed7b9a954741@epcas2p1.samsung.com>
        <1557912988-26758-2-git-send-email-stanley.chu@mediatek.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello Stanley,

On 5/15/19 3:06 PM, Stanley Chu wrote:
> Some vendor-specific initialization flow may set its own
> auto-hibernate timer. In this case, do not overwrite timer value
> as "default value" in ufshcd_init().
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>   drivers/scsi/ufs/ufshcd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index e040f9dd9ff3..1665820c22fd 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -8309,7 +8309,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
>   						UIC_LINK_HIBERN8_STATE);
>   
>   	/* Set the default auto-hiberate idle timer value to 150 ms */
> -	if (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT) {
> +	if (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT & !hba->ahit) {
>   		hba->ahit = FIELD_PREP(UFSHCI_AHIBERN8_TIMER_MASK, 150) |
>   			    FIELD_PREP(UFSHCI_AHIBERN8_SCALE_MASK, 3);
>   	}
> 
Looks good to me,
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
