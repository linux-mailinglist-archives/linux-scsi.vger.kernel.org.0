Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1567C423FC
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2019 13:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406439AbfFLLag (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Jun 2019 07:30:36 -0400
Received: from ns.iliad.fr ([212.27.33.1]:44138 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbfFLLaf (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 12 Jun 2019 07:30:35 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 0220320D88;
        Wed, 12 Jun 2019 13:30:34 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id E577A20A7E;
        Wed, 12 Jun 2019 13:30:33 +0200 (CEST)
Subject: Re: [PATCH v1] scsi: ufs: Avoid runtime suspend possibly being
 blocked forever
To:     Avri Altman <Avri.Altman@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Cc:     SCSI <linux-scsi@vger.kernel.org>
References: <1560325326-1598-1-git-send-email-stanley.chu@mediatek.com>
 <SN6PR04MB492546256F8F8635E7EE60C2FCEC0@SN6PR04MB4925.namprd04.prod.outlook.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <f83162dc-8e27-b592-812e-e6a0176ea3cd@free.fr>
Date:   Wed, 12 Jun 2019 13:30:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <SN6PR04MB492546256F8F8635E7EE60C2FCEC0@SN6PR04MB4925.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Jun 12 13:30:34 2019 +0200 (CEST)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 12/06/2019 13:10, Avri Altman wrote:

> On 12/06/2019 09:42, Stanley Chu wrote:
> 
>> Fixes: e3ce73d (scsi: ufs: fix bugs related to null pointer access and array size)
> 
> This code was inserted before platform_set_drvdata  in
> 6269473 [SCSI] ufs: Add runtime PM support for UFS host controller driver.
> Why do you point to e3ce73d?

Please note that the (current) convention is to show 12 characters
(not 7) for git hashes:

	git config --global core.abbrev 12

https://public-inbox.org/git/CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com/

Regards.
