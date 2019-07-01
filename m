Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086602EA9F
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 04:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfE3CWa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 22:22:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbfE3CWa (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 22:22:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A169309264C;
        Thu, 30 May 2019 02:22:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B63B60603;
        Thu, 30 May 2019 02:22:21 +0000 (UTC)
Subject: Re: [PATCH v2] scsi: smartpqi: properly set both the DMA mask and the
 coherent DMA mask in pqi_pci_init()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, don.brace@microsemi.com,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com, Thomas.Lendacky@amd.com,
        dyoung@redhat.com
References: <20190527005934.1493-1-lijiang@redhat.com>
 <yq14l5czopg.fsf@oracle.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <63f06e98-df6f-35dc-da41-dc039f04511d@redhat.com>
Date:   Thu, 30 May 2019 10:22:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <yq14l5czopg.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 30 May 2019 02:22:30 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

在 2019年05月30日 10:00, Martin K. Petersen 写道:
> 
> Lianbo,
> 
>> When SME is enabled, the smartpqi driver won't work on the HP DL385
>> G10 machine, which causes the failure of kernel boot because it fails
>> to allocate pqi error buffer. Please refer to the kernel log:
> 
> Applied to 5.2/scsi-fixes, thanks!
> 
OK, thank you, Martin K.

And also thanks to Tom and Don for helping review this patch.

Lianbo
