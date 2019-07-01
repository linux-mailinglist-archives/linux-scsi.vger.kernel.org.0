Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5FAC56CD6
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Jun 2019 16:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfFZOu4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Jun 2019 10:50:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37894 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfFZOuz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 26 Jun 2019 10:50:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so3078945wrs.5
        for <linux-scsi@vger.kernel.org>; Wed, 26 Jun 2019 07:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zKwCVXqNSdxUFQzItp//hcjzWX/6aPHoSCaD5m20WdA=;
        b=sMS14zzJ3IfPtRxUXTRE/lAASGWParFGPZpy3oJvi7Cx7+5x+HlxLe9W1/RUMvEo0N
         Lcavi7//6daYuFo51neC43cpoCl4km25WvQ9wNW8MrCO4Niso5dP/riyHI/MC/a+uOg+
         MGE5Sz5bat8MW81WWuHIWHh9AnqZc2qXeYt8fKb8Y2mWeeRKLQv3qary3ksFJV2Hpk91
         +6Ovsr1GSy16WDJ9Zd8c/aff295uz49Vrjk/L4c/I+TFN+XxqldT8J8GASvtBXPMdQeJ
         qsR5t0Sk4snI+M7clEbos3vM5lCXo86TepjkDrWYsnIu/lMdJY6buHuYMmbWng1OTnCR
         JJ7w==
X-Gm-Message-State: APjAAAVZvPb/OR2GEDODsSnLfzHRnO3DowiPszsH5hf4Jgtc+sG0VCt1
        offIUWFIsWcdcr3ATbk8h3FPKQ==
X-Google-Smtp-Source: APXvYqxycRsvlbgRNY6d2pMyCqDyrY9jNh7mW02JEED6LFOHbbuBdjHos3+Fqpxmv1eNh3joycNHMQ==
X-Received: by 2002:a5d:5143:: with SMTP id u3mr3622743wrt.118.1561560653972;
        Wed, 26 Jun 2019 07:50:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e88d:856c:e081:f67d? ([2001:b07:6468:f312:e88d:856c:e081:f67d])
        by smtp.gmail.com with ESMTPSA id x129sm2501891wmg.44.2019.06.26.07.50.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:50:53 -0700 (PDT)
Subject: Re: [PATCH 0/2] scsi: add support for request batching
To:     dgilbert@interlog.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, stefanha@redhat.com
References: <20190530112811.3066-1-pbonzini@redhat.com>
 <746ad64a-4047-1597-a0d4-f14f3529cc19@redhat.com>
 <65e5ad25-a475-989a-ce3d-400a8c90cb61@interlog.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cbb24317-7682-a854-4460-e8828db1eb25@redhat.com>
Date:   Wed, 26 Jun 2019 16:50:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <65e5ad25-a475-989a-ce3d-400a8c90cb61@interlog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 26/06/19 16:14, Douglas Gilbert wrote:
> 
> I have no objections, just a few questions.
> 
> To implement this is the scsi_debug driver, a per device queue would
> need to be added, correct?

Yes, queuecommand would then return before calling schedule_resp (for
all requests except the one with SCMD_LAST, see later).  schedule_resp
would then be called for all requests in a batch.

> Then a 'commit_rqs' call would be expected
> at some later point and it would drain that queue and submit each
> command. Or is the queue draining ongoing in the LLD and 'commit_rqs'
> means: don't return until that queue is empty?

commit_rqs means the former; it is asynchronous.

However, commit_rqs is only called if a request batch fails submission
in the middle of the batch, so the request batch must be sent to the
HBA.  If the whole request batch is sent successfully, then the LLD
takes care of sending the batch to the HBA when it sees SCMD_LAST in the
request.

So, in the scsi_debug case schedule_resp would be called for the whole
batch from commit_rqs *and* when queuecommand sees a command with the
SCMD_LAST flag set.  This is exactly to avoid having two calls to the
LLD in the case of no request batching.

> So does that mean in the normal (i.e. non request batching) case
> there are two calls to the LLD for each submitted command? Or is
> 'commit_rqs' optional, a sync-ing type command?

It's not syncing.  It's mandatory if the queuecommand function observes
SCMD_LAST, not needed at all if queuecommand ignores it.  So it's not
needed at all until your driver adds support for batched submission of
requests to the HBA.

(All this is documented by the patches in the comments for struct
scsi_host_template, if those are not clear please reply to patch 1 with
your doubts).

Paolo
