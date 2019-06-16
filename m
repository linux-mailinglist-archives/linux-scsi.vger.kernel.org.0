Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF39475FE
	for <lists+linux-scsi@lfdr.de>; Sun, 16 Jun 2019 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfFPQ5Q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 16 Jun 2019 12:57:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41631 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfFPQ5Q (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 16 Jun 2019 12:57:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id s24so3078231plr.8
        for <linux-scsi@vger.kernel.org>; Sun, 16 Jun 2019 09:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GhwEpgqcnkIbQICoIOECM25dXgJz8N0ZOtZwYSBU4iQ=;
        b=kI0GnTTCxzbI47VKskXA/gPMBbCO8AP7oAIQvfBZ7xQjS2vhUlea5NYXepkQaYQRf9
         zIwNXKHeEWZFJd0bOYjA2xi4TDCiVPyGqDkG3jhBkhxMpG7mw//IuMpb+0AUaOev01Mc
         duB16yjzWkdoDu/ltdjaAChe3RoMFFEW5sjp1TpgecETjPpHnTv799beRcKyVGm/f0v3
         eoOc3I1ltXqaRlT+4Keiu1OrUZaNvXjDofQRUwwfjPeZ6d8Mo2rhFYl4/Ug+g+AfQXFH
         +LA6411+vSfy/TKzOZ6hcyEq3gyZFXhMss43UXKwJLF+jckftPiW4APWh9ePr/7SXOEd
         F9RA==
X-Gm-Message-State: APjAAAUP1N05rOZVMuHu2L8fkfC9XH8eeYx3rVcwfoNpbGiiE11veGBt
        MH0vZ2uU6gjpa+XSieOPwvve9GeO
X-Google-Smtp-Source: APXvYqybETmhuqs+ZiadkUb3f5PrD66tDVvNXbiT09B3uCruYT6lyhTAPFv1YSdepvRW1XV7odp0dg==
X-Received: by 2002:a17:902:ab83:: with SMTP id f3mr13394449plr.122.1560704235156;
        Sun, 16 Jun 2019 09:57:15 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:28ed:a972:3848:ea6d])
        by smtp.gmail.com with ESMTPSA id l3sm7454572pgl.3.2019.06.16.09.57.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 09:57:14 -0700 (PDT)
Subject: Re: [PATCH 1/1] qla2xxx: move IO flush to the front of NVME rport
 unregistration
To:     Himanshu Madhani <hmadhani@marvell.com>,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
References: <20190616150553.28399-1-hmadhani@marvell.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8670ef36-3c29-1411-3849-713ea8649ac7@acm.org>
Date:   Sun, 16 Jun 2019 09:57:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190616150553.28399-1-hmadhani@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/16/19 8:05 AM, Himanshu Madhani wrote:
> +	INIT_WORK(&sess->free_work, qlt_free_session_done);
> +	schedule_work(&sess->free_work);

Since you are touching this code and since there are multiple 
schedule_work() and flush_work() calls in the qla2xxx driver code for 
this work item: please move the INIT_WORK() call to the session 
initialization code. Calling INIT_WORK() while another thread can call 
schedule_work() or flush_work() on the same work item is racy.

Thanks,

Bart.
