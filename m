Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3110B69478
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Jul 2019 16:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404592AbfGOOvk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 15 Jul 2019 10:51:40 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:45240 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404400AbfGOOvj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 15 Jul 2019 10:51:39 -0400
Received: by mail-pl1-f181.google.com with SMTP id y8so8402250plr.12
        for <linux-scsi@vger.kernel.org>; Mon, 15 Jul 2019 07:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BKSJgT6whNkC5IhAzvavX76L682ogf/O2G93SLLSkJU=;
        b=b0d2J4xCCm0KNw/qj3HIU8dYECM7kBb774a2roV1NDXUzy40acvViTNPkLvMpoeVy1
         CFSHyq1ZWedJfp86ClW84qNkq1AjRgF+v+RZqi0+inn2UabmAyUxV8qNJIZC6G4oO26n
         w29BK0hVtBXD4LwjALyTVznYtlCg3Qm/ZEq7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BKSJgT6whNkC5IhAzvavX76L682ogf/O2G93SLLSkJU=;
        b=N6mpFRMqSxyRRX0Zm7l72NrhkUZQEZb7P8fcI/vmxSjqy5sb3ATflmw8ZdG5ypDTQ/
         GEZT6/+edlox8ep2KUQteIzcoMkDvBuZw124U8pz12hQWWEuwNeb9lKgQTKTCNgsZD7S
         0Ed6QekASPP3lM8J29lADTTznWu8b18CoYZD7ct7s4A9al5dWoJWmqfZqZh/P43tXPEo
         8xTjqGn4eQgkVSKE5qXpNpEAVqglSh7bbWzYcCdg4BscEl92ITEdwUxcz5QRBfS774YJ
         TYtt86UPS+A7wIkGW8XcZscdw/+k8e+CPcch2ZQQSfxShuMdxTF1wwr/OoC1ptEotMTk
         dZew==
X-Gm-Message-State: APjAAAX470zc7AwE+pza2uWHgAmhPu85bRPbXwNkAZ/YmLqTUvOEqQVf
        OHFlV1lT6PI5ExrfkTKI+4ExTnAHzdh9o8wUQc8u06a0pbym6ETqv7sLKjodFzvCksIoR5XNCjY
        K/glwS1q3oNQe3MGZMT1Kl4ieaHKFkCa7+UATFo87Syq7o+9/2pGkVhTuc/BiQy1ppD6p9h4WCR
        1v
X-Google-Smtp-Source: APXvYqzs6mlTcK+ml7tdLCyuJNk2RhWR6UrxxN4jOQP+aclPWgn+HI40YmyK+mAZDxd/IftfWFnwrg==
X-Received: by 2002:a17:902:968d:: with SMTP id n13mr29180895plp.257.1563202298366;
        Mon, 15 Jul 2019 07:51:38 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 30sm47698095pjk.17.2019.07.15.07.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 07:51:37 -0700 (PDT)
Subject: Re: [PATCH -next] scsi: lpfc: Remove unnecessary null check before
 kfree
To:     YueHaibing <yuehaibing@huawei.com>, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20190711141037.57880-1-yuehaibing@huawei.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <3a56b01a-27e4-6ebc-0e99-8a06a2f2f75f@broadcom.com>
Date:   Mon, 15 Jul 2019 07:51:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711141037.57880-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 7/11/2019 7:10 AM, YueHaibing wrote:
> A null check before a kfree is redundant, so remove it.
> This is detected by coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/scsi/lpfc/lpfc_bsg.c | 4 +---
>

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james
