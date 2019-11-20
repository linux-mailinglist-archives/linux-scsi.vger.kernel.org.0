Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F7B104076
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Nov 2019 17:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfKTQOm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 20 Nov 2019 11:14:42 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:43238 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfKTQOm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 20 Nov 2019 11:14:42 -0500
Received: by mail-pj1-f68.google.com with SMTP id a10so36722pju.10
        for <linux-scsi@vger.kernel.org>; Wed, 20 Nov 2019 08:14:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=okCR7ull6TGR2sbz/PAnGP42JxaVuuZVEIYaWn2kSUI=;
        b=OqXXoZYzHkRlT6f7kwPiDwiHebD84NCCbkY9dq5UVMzvdOrFJPZGvWDhNPjOvbA9kD
         e4SOv0My22blxKp2BwDo9O3c1n/hC7H1gDsfmKZECFioOpIo03nHw/idsaMqAAos1+Ng
         SAywxYUPJj9brntI90iZTg4yopUl/Hy5W0MX9hHdiCljVIIO7XYcAOa9srt/W4PmuUQN
         cv8fQnxrfCV4SzTajCMgjmd+e0HwLha7HrZg3ZTTU9U7MooVfsezVEvdGH8D69a2EACX
         v/+PG5fEL/vsELTOAlN/DWUgVPIAwr8EDrdbHV/2lwWC9CEMXefTGN0tVg6cvTGPhEDc
         Eu7w==
X-Gm-Message-State: APjAAAV7aqpQDeB2CX41GcpYjEP10S+4mopwXvI2OJiSH/8EVJQHgVz5
        CtVNUXEgt1hLmENsqHqmj84=
X-Google-Smtp-Source: APXvYqxu/X/VFpudyCkc200nr5xmF6+rAesQcM3q2vBx0RMraL4S7GKTHu3gzZSt99/wHw9C99XWeA==
X-Received: by 2002:a17:902:9b8f:: with SMTP id y15mr3584075plp.54.1574266481730;
        Wed, 20 Nov 2019 08:14:41 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b13sm23072030pgj.28.2019.11.20.08.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 08:14:40 -0800 (PST)
Subject: Re: [PATCH 06/11] aacraid: replace aac_flush_ios() with midlayer
 helper
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org,
        Balsundar P <balsundar.p@microsemi.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
References: <20191120103114.24723-1-hare@suse.de>
 <20191120103114.24723-7-hare@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3b7a9b3f-00c5-fcdd-5e88-d9ea8ffc94f2@acm.org>
Date:   Wed, 20 Nov 2019 08:14:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120103114.24723-7-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/20/19 2:31 AM, Hannes Reinecke wrote:
> Use the midlayer helper scsi_host_flush_commands() to flush all
> outstanding commands.
  Reviewed-by: Bart Van Assche <bvanassche@acm.org>
