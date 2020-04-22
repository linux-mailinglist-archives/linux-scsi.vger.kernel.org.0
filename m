Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762AB1B50B2
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2020 01:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgDVXNg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Apr 2020 19:13:36 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39613 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDVXNf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Apr 2020 19:13:35 -0400
Received: by mail-pj1-f67.google.com with SMTP id e6so1646505pjt.4;
        Wed, 22 Apr 2020 16:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Oz+YrWC5V3MyRV+fA4cwe0p6pOMK21KqQtpkcQDX10=;
        b=ovC/KcVJM3E86z2QfvQZUpbsvsZMwggbUl8amqfDuGZQCNlmUR2cojJghtq5IPfdWj
         3Eo8n2Bwva/4aaYiTgm3ncw1tGcbX40429rykO7g5MXmPPtzTatXXYc6/XzYCCGos1og
         5t7VP7ZIzwXNx+o09AziA2n0RSoFdAKRR2RmS1+Sb4mMewG19hSMK0rK0C5kuTF/7H4I
         F3DRJ/f4f9QDqqyoFebv+FqAiQds6X2XrWlxlXPDRSUsmri7m1LKjsmIaYUT+gCezD5d
         qhiuqr6V1Xg53YJ/h9OM5Ez9wlOyTJ0SosbSwVWxid39ouvUH2yZYW0KpcSB/+B6M+ro
         yq3Q==
X-Gm-Message-State: AGi0PuakvXB+Xn+79+L9tjZ6R2Ui7r6uOw5P4wdKpNcsMNtCIULz4VIh
        /Cqx39Oo+EcCr7jj0HmgO8xbY1+eAx4=
X-Google-Smtp-Source: APiQypLfsOG1NIF5GXcztQ1Dn+ng0Ewm0QbDviIyChSCcEuANmPGd6ErimTe2I2ccMEWAFIdUpCSpQ==
X-Received: by 2002:a17:90b:374f:: with SMTP id ne15mr1094574pjb.181.1587597214344;
        Wed, 22 Apr 2020 16:13:34 -0700 (PDT)
Received: from [100.124.12.67] ([104.129.198.228])
        by smtp.gmail.com with ESMTPSA id p64sm314014pjp.7.2020.04.22.16.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 16:13:33 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] scsi: ufs: add ufs_features parameter in structure
 ufs_dev_info
To:     huobean@gmail.com, alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200416203126.1210-1-beanhuo@micron.com>
 <20200416203126.1210-4-beanhuo@micron.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <922c687a-2023-8a78-b6c7-7c3c8a40ae32@acm.org>
Date:   Wed, 22 Apr 2020 16:13:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416203126.1210-4-beanhuo@micron.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/16/20 1:31 PM, huobean@gmail.com wrote:
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 83ed2879d930..1fe7ffc1a75a 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -6625,6 +6625,8 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
>   		goto out;
>   	}
>   
> +	dev_info->ufs_features = desc_buf[DEVICE_DESC_PARAM_UFS_FEAT];
> +
>   	if (desc_buf[DEVICE_DESC_PARAM_UFS_FEAT] & 0x80) {
>   		hba->dev_info.hpb_control_mode =
>   			desc_buf[DEVICE_DESC_PARAM_HPB_CTRL_MODE];
> 

Since this change is very closely related to the changes in patch 1/3, 
please merge this patch into patch 1/3.

Thanks,

Bart.
