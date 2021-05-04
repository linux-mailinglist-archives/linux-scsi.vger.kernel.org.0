Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A1B372474
	for <lists+linux-scsi@lfdr.de>; Tue,  4 May 2021 04:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhEDC3r (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 May 2021 22:29:47 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:40892 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhEDC3r (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 3 May 2021 22:29:47 -0400
Received: by mail-pg1-f176.google.com with SMTP id y30so5363554pgl.7
        for <linux-scsi@vger.kernel.org>; Mon, 03 May 2021 19:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TveYeQsuvFx+3pAYsXe6h4QEuQflFe6jJ4R2BSyUG0Q=;
        b=G+uNsUMuKPXbf8UGHI1+0lsbpt5sY3qZFb3CwRnMAy+mzdi6UbGAxI/DFeFMSMIu32
         C2R3yU/6VH2YPabMkI1i4wPQdFi7uqDRC6jD9IjiWml6UwHr1IQ7+B2gJK6RvRlD6p2W
         XLBqDEwsX5EJjS65NWFq7/XRF8xHcbzjsnmFz6ItJAelYNTWmJDxjQBQTCCfgUDQudXf
         u6NkPa11hB8Mqfvt2oSQiftrDeW15to4sJm1/0yMCZknaEVEA9RXnMqG/pC5pamY6DQ3
         pHSDqGXAmYNlRITQSrBcHEIK9248iWQZpA+mhIOH+2DYx8/3F+FUvJ85lNKN/vFYv/63
         gfuA==
X-Gm-Message-State: AOAM532mT5rq1U5grecbxKlTDF1f7liQ7Ft3He5N00BeTkUYAPwh1qiH
        yUbt37V9Vh17Sq63TDoNUHJocH30RHc=
X-Google-Smtp-Source: ABdhPJweeBN82FZLuWMsX5FagSRwyh95G3rWzV4YC6Cva6xFTsAKdqB2YZIz7c8QW4dmG1SJJn9Vgw==
X-Received: by 2002:a17:90a:ba16:: with SMTP id s22mr25063004pjr.12.1620095331569;
        Mon, 03 May 2021 19:28:51 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:6b81:314d:2541:7829? ([2601:647:4000:d7:6b81:314d:2541:7829])
        by smtp.gmail.com with ESMTPSA id f15sm1193203pgv.5.2021.05.03.19.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 19:28:51 -0700 (PDT)
Subject: Re: [PATCH 05/18] scsi: use real inquiry data when initialising
 devices
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org
References: <20210503150333.130310-1-hare@suse.de>
 <20210503150333.130310-6-hare@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2007236f-0778-6b27-74bf-29c768cf1efd@acm.org>
Date:   Mon, 3 May 2021 19:28:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210503150333.130310-6-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/3/21 8:03 AM, Hannes Reinecke wrote:
> Use dummy inquiry data when initialising devices and not just
> some 'nullnullnull' string.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
