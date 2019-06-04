Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57EED34EFD
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 19:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfFDRek (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 13:34:40 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:34308 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfFDRek (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Jun 2019 13:34:40 -0400
Received: by mail-pg1-f179.google.com with SMTP id h2so7519155pgg.1
        for <linux-scsi@vger.kernel.org>; Tue, 04 Jun 2019 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4WbrwLtDUXe8HTAdFzSzCI6MmrDej8XdLtQH+1WkJxA=;
        b=hFHICOXg5ScO/YJHqqF2FT4bBiGpihOGIKHl5ID+Fs7tuhHLCoUimQ0j0R13OTcCQ2
         oGYLIiOMyPJnydwnG4SKSpMpOoOWyqjSupIMzF3lQonYeamho4X6Ke/doYsodwYO9Xhj
         PBZs1IPvalwX9HhiwmW3el7cCkMlcpYAta4yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4WbrwLtDUXe8HTAdFzSzCI6MmrDej8XdLtQH+1WkJxA=;
        b=pYTwyV4O4m4esmuSxiEJYW8yb569jJCxtmB3Tvu8Oo1+GA7QOgcUClAEUgD+GuSax3
         ByqPYbjmapWXyV0jStkppG9TC36eVNXw2w07dV+bCPwwa8pTjSEORpigDDH5Fy6HtCoQ
         WeJQdRUS5lzGeZfqrI0q3mEun4LIoHUXaw4+b9AcGExn72yijGF5fR/SEKqx+lG91VGi
         Om1OK+JJpksj9wz/CLgKuZTQUuU1WhcjvoSeHIdoIuxDCh9sl1u1EZFqkCT//HejxjTi
         +CP1FfvqUDV1Z45s3R+AEig8JMBFfSIfaPFQRbXmJGeOzSNs464ySV5TWLGifCSOocGs
         vxAQ==
X-Gm-Message-State: APjAAAUApf6DE0hnbT55uftaksE7cOyTzSL0g915HKh21UIorkDI2wL+
        Eq8tp+blPRSFKOAkNx77FerjaCjuvtbsthHxn4qgONtDdgGr34cjRGYjXHI2skUfmS4Bj0Y45q6
        H2X0FXdSThw61EZ9a8dRewLmiyfoxZFis+Pg46H6/aAZZpMtv5LXxX7VOtoyNbSUFCJnn/XdcRO
        P8
X-Google-Smtp-Source: APXvYqwHenvbeywYajmzkPeaxvyRPC5N7HRT3eOsx4Ooigcvtbetz+9AEtW/a6j/0W3/q8+gKqmgiA==
X-Received: by 2002:a17:90a:23ce:: with SMTP id g72mr32288861pje.77.1559669679303;
        Tue, 04 Jun 2019 10:34:39 -0700 (PDT)
Received: from [10.230.29.90] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n184sm19870059pfn.21.2019.06.04.10.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:34:38 -0700 (PDT)
Subject: Re: [PATCH -next] scsi: lpfc: Remove set but not used variables 'qp'
To:     YueHaibing <yuehaibing@huawei.com>, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        jsmart2021@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20190531152745.7928-1-yuehaibing@huawei.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <a9496faa-6dd3-47dc-b5ba-7716c2b21940@broadcom.com>
Date:   Tue, 4 Jun 2019 10:34:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531152745.7928-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 5/31/2019 8:27 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warnings:
>
> drivers/scsi/lpfc/lpfc_init.c: In function lpfc_setup_cq_lookup:
> drivers/scsi/lpfc/lpfc_init.c:9359:30: warning: variable qp set but not used [-Wunused-but-set-variable]
>
> It's not used since commit e70596a60f88 ("scsi: lpfc: Fix
> poor use of hardware queues if fewer irq vectors")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>

Looks good - thank You

Reviewed-by: James Smart  <james.smart@broadcom.com>

