Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5734D8E8
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Mar 2021 22:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhC2UQS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Mar 2021 16:16:18 -0400
Received: from mxout04.lancloud.ru ([45.84.86.114]:35876 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhC2UPt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Mar 2021 16:15:49 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru CCDE42131909
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Subject: [PATCH v2 0/3] Stop calling request_irq() with invalid IRQs
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
Organization: Open Mobile Platform, LLC
Message-ID: <ef3823c1-ee4a-5e9a-0a56-85f401ffa9dd@omprussia.ru>
Date:   Mon, 29 Mar 2021 23:15:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Here are 3 patches against the 'fixes' branch of Martin Petersen's 'scsi.git' repo,
2 of them were previously posted separately, the 3rd is a new addition.

The affected drivers call platform_get_irq() but ignore its result -- they blithely
pass the negative error codes to request_irq() which expects *unsinged* IRQ #s. Stop
doing that by checking what platfrom_get_irq() returns.

[1/3: scsi: jazz_esp: add IRQ check
[2/3] scsi: sun3x_esp: fix IRQ check
[3/3] scsi: sni_53c710: fix IRQ check
