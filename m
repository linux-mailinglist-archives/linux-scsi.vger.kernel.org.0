Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A5E34EFF4
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Mar 2021 19:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhC3RlF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Mar 2021 13:41:05 -0400
Received: from mxout03.lancloud.ru ([45.84.86.113]:39976 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhC3Rkp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Mar 2021 13:40:45 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 1B24520601AD
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH v3 0/3] Stop calling request_irq() with invalid IRQs
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
Organization: Open Mobile Platform, LLC
Message-ID: <137b9e4d-391f-3163-2e6f-9e21aeb6bf34@omprussia.ru>
Date:   Tue, 30 Mar 2021 20:40:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Here are 3 patches against the 'fixes' branch of Martin Petersen's 'scsi.git' repo.
The affected drivers call platform_get_irq() but ignore its result -- they blithely
pass the negative error codes to request_irq() which expects *unsinged* IRQ #s. Stop
doing that by checking what platform_get_irq() returns.

[1/3: scsi: jazz_esp: add IRQ check
[2/3] scsi: sun3x_esp: add IRQ check
[3/3] scsi: sni_53c710: add IRQ check
