Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A800EC6E4
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Nov 2019 17:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfKAQgn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Nov 2019 12:36:43 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:39847 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfKAQgm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 Nov 2019 12:36:42 -0400
Received: by mail-pf1-f175.google.com with SMTP id x28so4209714pfo.6
        for <linux-scsi@vger.kernel.org>; Fri, 01 Nov 2019 09:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cjzx/fHQKAXnPiemr4wvjetSLsbUQceifBeoEyyejyM=;
        b=C+PGuT42oWtuRC3Pc4cX0tuw3dS5aDYWyujI8EZETUp19qz6G3cTY4rZdXxuMAmKKS
         ySxfV+zYtP/bA9QEKRnI9op4Xixl3pGoMmNLaHdwncxoszwk35Ef2asDlLdIs5T5LjgR
         jJpYofJJLrRUeAbV531uc0slvbuA3MqdBEg2xaIYmrHE1ANE9JsIK2SnGRzSJH6Keyh8
         +aTEeyum71+hgb8Z0dtPaHHPUywBM5wVowBnV6lTBsgDqOi6KzPGrnWsKTy7frzqkwPe
         UFoEoLG8EXaiVgoGA8dtAqW95okqhHpXK5ta4jeLaCzncvK9lUtNVTL/o9WDTcSlD2yC
         zw6A==
X-Gm-Message-State: APjAAAVeShFan7LHz+zvykhO8nEzsTNXY6uGCGaEhc3Toa+JbCZcBEcS
        CtKT6Rjuq2FRQ6+LkZNfqTdbcw3Aihg=
X-Google-Smtp-Source: APXvYqxkPrjSR1YNljN4NeSkEK5Dhm+L/a9TcdMzfkrbcbylAs68344mnQ3z47Cs5NqETo0Kc1RIqQ==
X-Received: by 2002:a63:fe15:: with SMTP id p21mr14058076pgh.26.1572626201796;
        Fri, 01 Nov 2019 09:36:41 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y17sm6819337pfl.7.2019.11.01.09.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 09:36:41 -0700 (PDT)
Subject: Re: [PATCH 10/24] scsi: introduce set_status_byte()
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20191031110452.73463-1-hare@suse.de>
 <20191031110452.73463-11-hare@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f9bf5959-f403-5b83-b4e8-964a4c6c2319@acm.org>
Date:   Fri, 1 Nov 2019 09:36:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031110452.73463-11-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/31/19 4:04 AM, Hannes Reinecke wrote:
> To be in-line with the other set_XX_byte() functions.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
