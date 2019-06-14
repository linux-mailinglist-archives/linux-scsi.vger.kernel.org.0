Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 416C7468D1
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2019 22:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfFNUZW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Jun 2019 16:25:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46129 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFNUZW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 14 Jun 2019 16:25:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so2065635pfy.13
        for <linux-scsi@vger.kernel.org>; Fri, 14 Jun 2019 13:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j9sYU9ZbZNyYZlyRo+JyUijIkgxJOehfv1U4uwckqCw=;
        b=ZCMgi5fZAQQ6ImVDmRGKzfcw+7RQWejcQ0JE9ySi7ov+srlm6KPVR6rV18LpNXA7AQ
         zz4jI7cLuknDLneVGLb+4dZmmKH4eEVTSddI0xvUl7VXyJJrdsULaiuW+rwm4suZKe35
         2jMN3a5ieNN/HBD1DE9OWKfCGOfAU7W9lLLmr25+GucIiTXI4X/L74Fwd18ayE+1ru+a
         0HOtuLrWZVOmCa8lD5nOL8IAtxW7s4hB7XKKRXBKhODhMHUaJRqbcVUS5flhGcw1nIXd
         R4QcEsKyJW6LMA98mF1xoW6Evd8n36BBy5mHp775jeyKyxeS+uQM6K927XGUq+QEXqSe
         +HCA==
X-Gm-Message-State: APjAAAXYcHvrcwnFAo7ZjGWzKGL4APFeG02czcbiisiuXjYhWkf5jDs/
        5++mq1Ujncs73A4dwyQ2ZLXbf7gt
X-Google-Smtp-Source: APXvYqzhYAZmauDBe9+FZW6IAVXXSkXtFk+GTxxd8kYG4y/3Pk+TsCeUOo7xM90vo2NTf2Bd0cx05g==
X-Received: by 2002:a17:90a:d814:: with SMTP id a20mr13060338pjv.48.1560543921321;
        Fri, 14 Jun 2019 13:25:21 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z11sm3266146pjn.2.2019.06.14.13.25.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 13:25:20 -0700 (PDT)
Subject: Re: [PATCH] qla2xxx: Fix hardlockup in abort command during driver
 remove.
To:     Himanshu Madhani <hmadhani@marvell.com>,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
References: <20190614143627.10768-1-hmadhani@marvell.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <cfadf755-d97d-3c37-c02d-a95512d31771@acm.org>
Date:   Fri, 14 Jun 2019 13:25:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614143627.10768-1-hmadhani@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/14/19 7:36 AM, Himanshu Madhani wrote:
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> index 172ef21827dd..d056f5e7cf93 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -1731,8 +1731,8 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
>   	     !test_bit(ABORT_ISP_ACTIVE, &vha->dpc_flags) &&
>   	     !qla2x00_isp_reg_stat(ha))) {
>   		sp->comp = &comp;
> -		rval = ha->isp_ops->abort_command(sp);
>   		spin_unlock_irqrestore(qp->qp_lock_ptr, *flags);
> +		rval = ha->isp_ops->abort_command(sp);
>   
>   		switch (rval) {
>   		case QLA_SUCCESS:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
