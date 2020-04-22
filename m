Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637941B476E
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2020 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgDVOg1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Apr 2020 10:36:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34285 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVOg1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Apr 2020 10:36:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so1191419pfa.1
        for <linux-scsi@vger.kernel.org>; Wed, 22 Apr 2020 07:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yVPdt2Bhs/etjlRMJv52F6s7nrYDQ5/BAaE8UKJBN48=;
        b=NcihR7ElTVRNU8NWI76EE7Kb4J4pLUKWZm7tQu60ssV5cQ4fLgt+i+/ow9G2ayQgJ3
         SIB4CvtCexDsT0YTKGHyMTiaWncatnc/kkzBu6fhKkImQzd1eoXCe9KzJbg/ypj3Plor
         mVx/wLiGPJB/s/fx8DxwO6OnqxQt0LNhVmxky1dmA5S93RNDOekCOL4jK08xr4v/nM9K
         fx2SE/umfTfGVQXE3D80BYXJV6H54B7ons3aLynnscns6682VzLdOZqGDp45Th1/KCa0
         ryoHR90/tUTRjc36gn7Sq2SASQxLd5FQPmOAs+Q5v4wogk3/5hxTOPW3Cx5bp6x3pnMi
         HMxQ==
X-Gm-Message-State: AGi0PuYKCPs5hinQYS2/P11vBpugm418muazPe8vdl35MFbPQEB21gvE
        Drl49bz5up8o43vGgDPo1t0=
X-Google-Smtp-Source: APiQypIoE/adIfUVMoCR0Yv36ORDk1SJxaLBic8JVaq5vReaIDUpcEsyzSa/OW8GBzNhMZO1H8rB9A==
X-Received: by 2002:a63:9801:: with SMTP id q1mr27631132pgd.447.1587566186613;
        Wed, 22 Apr 2020 07:36:26 -0700 (PDT)
Received: from [100.124.11.187] ([104.129.198.222])
        by smtp.gmail.com with ESMTPSA id p10sm5760552pff.210.2020.04.22.07.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 07:36:25 -0700 (PDT)
Subject: Re: [PATCH V2] scsi: put hot fields of scsi_host_template into one
 cacheline
To:     Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>
References: <20200422095425.319674-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <280db221-4c97-2a23-762b-63fbc24b9c27@acm.org>
Date:   Wed, 22 Apr 2020 07:36:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422095425.319674-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/22/20 2:54 AM, Ming Lei wrote:
> The following three fields of scsi_host_template are referenced in
> scsi IO submission path, so put them together into one cacheline:
> 
> - cmd_size
> - queuecommand
> - commit_rqs

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
