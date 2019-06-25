Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A3054FC5
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 15:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfFYNF4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 09:05:56 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:50714 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbfFYNF4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 09:05:56 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190625130554epoutp015a03c731d8374e66aa8c2a58d71597b0~rctTW3-tq0314703147epoutp01L
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 13:05:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190625130554epoutp015a03c731d8374e66aa8c2a58d71597b0~rctTW3-tq0314703147epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561467954;
        bh=SzKCe4+Sc9lt7brPnRnOBQ+CfgHKlZDYLTSIKaovreo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=W1OwQCpWDouGLMVm0vzxOKYVph33zVCIMCF//NHFhkd5d1z30BNb1ct79nnVOIep9
         98HYTK0vVmLKmgJ2FcsmH/b+7UXAl0Ew7SViVWOpTLBriJFdPFe+VBtYfiNvOXSMiv
         f7inkyl3bY1LwEc0MhJG3nON+o59X8a01q3H5g/s=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20190625130553epcas5p37417664d9abc51afaba711987964c483~rctTA1CTL2315223152epcas5p3-;
        Tue, 25 Jun 2019 13:05:53 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.54.04071.13C121D5; Tue, 25 Jun 2019 22:05:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20190625130553epcas5p3c495b378785f3c88543dca31183c42cc~rctSStQAu2318523185epcas5p30;
        Tue, 25 Jun 2019 13:05:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190625130553epsmtrp239a950b39f02df4feb29127ab8b4e904~rctSRzoZl0790407904epsmtrp2L;
        Tue, 25 Jun 2019 13:05:53 +0000 (GMT)
X-AuditID: b6c32a49-5b7ff70000000fe7-84-5d121c310538
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.00.03662.03C121D5; Tue, 25 Jun 2019 22:05:53 +0900 (KST)
Received: from [107.108.73.28] (unknown [107.108.73.28]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190625130550epsmtip2dc68f87aa56449c2f9e827495615ca7d~rctQFBh8h0348003480epsmtip2k;
        Tue, 25 Jun 2019 13:05:50 +0000 (GMT)
Subject: Re: [PATCH] Documentation: scsi: ufs: announce ufs-tool v1.0
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Avri Altman <avri.altman@wdc.com>
Cc:     Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Doug Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Arthur Simchaev <Arthur.Simchaev@sandisk.com>
From:   Alim Akhtar <alim.akhtar@samsung.com>
Message-ID: <d4e4cd78-18d1-1087-87f0-cb87f6ae99e5@samsung.com>
Date:   Tue, 25 Jun 2019 18:15:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1561466160-13512-1-git-send-email-Arthur.Simchaev@wdc.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec/Ozs5Wy9dl+aRhtbJIyUsZnA+iYRdO5IegD6k0bNXBTJ12
        5iWlxMguauGlSJ2WVqhlI8nWBUvUhU4LDU3zUqHRJLRcqcwrWW1nld9+7///f97neeChRQqr
        2I2O1iRyvEYdq6Rk5JOXm722+K9WqPy+TQQwbWY9xbx7cID5WdAiYeZq+iRMVn6lmLHWlYuY
        kdkeimn6lEUy7ZVNFHN+sJBgqvM1TK/Rgpic3mcUU2VaIJjMFivJVDzuRzswOz9XgNiSjE6S
        vfNihGCHjI9INrOtgWSnay5R7PjwAMle178hWEPDJGInaz3Yi405xP4lEbLAY1xsdDLH+wYd
        lh1vyG1DCUbZqQ5DlyQDddHZSEoDDgC9tZ/IRjJagZ8j0LfeR8JjAsFonsnhTCEoHp9G/0oM
        gyLBqEcwpLvnSI0hyDYNU7bUcrwbvuou2g0XXE/AwJfvdkOEmwmofL/TxhT2ho+Fhj8hmpbj
        IOi4dsImk9gTaqyd9vgKHAZvDXX2znLsDG3FZtLGUszCaOsAIXzpCgPmMgevgadjpfbpAHdI
        oOtGkUgYexfMln9x8HIYNRkkArvBpKWess0AOAYu120T5NNQcbOFFDgYGrtLSVtEhDdDTZ2v
        0GoZXJk3E0KlHC5dUAhpTzhn6XFUukN+To5YYBZMtyx2XYFLEJS85PPQWt2ixXSLltEtWkb3
        v3E5IqvRKi5BGxfFabcn+Gu4FB+tOk6bpInyORofV4vsx+i19xnSdYQaEaaRcql8pgWrFGJ1
        sjY1zoiAFild5BXqP5L8mDo1jePjI/mkWE5rRO40qXSVF4h7DilwlDqRi+G4BI7/6xK01C0D
        pTp1h0TEaA589jgS/CP+9NFNJdEFr1R8ZJGsXaU5OJidso8PdNqoyxzdOaWcO7ShKuRt4wbV
        jJlzT3rYPL2+6aRbbaPziqv63vDH6VIvy1mL+9iRkMkF6URwa2jZ69KtH5q9V3bGj4UX+Vnm
        cjt/3HbtHW84Y+wbTtuT9etwWPrddUpSe1zt7yXiterfT0ij74gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02RbUhTYRiGe885np2tRm/T8FXLwSgCI8uIeg1ZQhiHAg36k9HSQ578yH2w
        40cLKiHLLyiVUNpMpVJLRqKbJWZMl8wt0FAza2kmaGJWFrK0RZLbDPbv4n7u6+GBhyFlg1Qk
        k63J4/UaLldBS6inLxXyPXHbZKp9HY8I7Jox0/jtk1P4b7VDhL1t70S4rKo5BHu6G0k8/3uM
        xn3TZRQebO6j8Y2pWgK3VmnwuP07wBXjXTRuGVglcLHDQ+GmzvcgEbJ/vNWANRUNU+yDnnmC
        /WS3UGyxy0axy22lNPtz1k2xNebXBGu1LQF2qSOaLemtIE5uPCNJyOBzswt4/V5luiTLdtsF
        dHbJpSHriKgIjDDlQMwgeACZrVNkOZAwMvgcoKllNxEYRKHx9kpRgEPR49U5P8vgAkDuxV0+
        DoVJaMFY4u+HQRuBptuv+BaRcIBApR7n+lYTQDbzHO1r0XA3mqy1rhkMI4VKNHQnxxdTcCdq
        8wz7K1vhaXTrpsnPUrgFue7OUD4WQxZ9cQaOI+FBVG+ZJgMcjtwzDeu5HD37VkdWApkxSDcG
        KcYgxRikNAKqFUTwOkGdqRbidPs1fGGswKmFfE1m7HmtugP4nxwT0wWczjQ7gAxQbJI29kOV
        LIQrEAxqO0AMqQiTNnFrkTSDM1zm9do0fX4uL9hBFEMpwqVyrSNVBjO5PP4iz+t4/f8pwYgj
        i0D02UPUxIj4x2h+b08fEKWEfF2OGDW8qR4bvH/VItLUM15l8cLijmMGd/JxXX1dp9vQWtNy
        4kXD59mU7bMbclTDFmblqFfZdOHVivzcaFeC1vFw/mOSMX7ClfwrPYVx3hsI/RB/zaTqXl0p
        7DULicTm60cmEx1ukas/w354rEZBCVlcXAypF7h/a3b8LuACAAA=
X-CMS-MailID: 20190625130553epcas5p3c495b378785f3c88543dca31183c42cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190625123640epcas1p2b043961d1b03d2fea1f3c9ddc8d2760d
References: <CGME20190625123640epcas1p2b043961d1b03d2fea1f3c9ddc8d2760d@epcas1p2.samsung.com>
        <1561466160-13512-1-git-send-email-Arthur.Simchaev@wdc.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Arthur,
Does this tools provides a way for ufs device partition provising from 
user space as well?
(have not used this tool till now, planning to use soon)

On 6/25/19 6:06 PM, Arthur Simchaev wrote:
> From: Arthur Simchaev <Arthur.Simchaev@sandisk.com>
> 
> The ufs-tool stable release v1.0 is available at
> https://github.com/westerndigitalcorporation/ufs-tool
> 
> Feedback and bug reports, as always, are welcomed.
> 
> Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
> ---
>   Documentation/scsi/ufs.txt | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/scsi/ufs.txt b/Documentation/scsi/ufs.txt
> index 1769f71..ae4643f 100644
> --- a/Documentation/scsi/ufs.txt
> +++ b/Documentation/scsi/ufs.txt
> @@ -158,6 +158,11 @@ send SG_IO with the applicable sg_io_v4:
>   If you wish to read or write a descriptor, use the appropriate xferp of
>   sg_io_v4.
>   
> +The user-space tool that interacts with the ufs-bsg endpoint and uses its
> +upiu-based protocol, is available at
> +https://github.com/westerndigitalcorporation/ufs-tool.
> +For more detailed information about the tool and the tool's supported
> +features, please see the tool's README.
>   
>   UFS Specifications can be found at,
>   UFS - http://www.jedec.org/sites/default/files/docs/JESD220.pdf
> 
