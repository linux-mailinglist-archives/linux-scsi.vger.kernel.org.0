Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C57A1B912
	for <lists+linux-scsi@lfdr.de>; Mon, 13 May 2019 16:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbfEMOvG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 May 2019 10:51:06 -0400
Received: from ns.iliad.fr ([212.27.33.1]:35232 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbfEMOvG (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 13 May 2019 10:51:06 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 3F90D1FF44;
        Mon, 13 May 2019 16:51:05 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 0834A1FF2B;
        Mon, 13 May 2019 16:51:05 +0200 (CEST)
Subject: Re: [PATCH v1 0/3] scsi: ufs: add error handlings of auto-hibern8
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, avri.altman@wdc.com,
        alim.akhtar@samsung.com, pedrom.sousa@synopsys.com
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com,
        sayalil@codeaurora.org, subhashj@codeaurora.org,
        vivek.gautam@codeaurora.org, evgreen@chromium.org,
        beanhuo@micron.com
References: <1557758186-18706-1-git-send-email-stanley.chu@mediatek.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <55818bc4-d464-bb35-25bb-9ef87af8224e@free.fr>
Date:   Mon, 13 May 2019 16:51:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557758186-18706-1-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon May 13 16:51:05 2019 +0200 (CEST)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 13/05/2019 16:36, Stanley Chu wrote:

> Currently auto-hibern8 is activated if host supports
> auto-hibern8 capability. However no error handlings are existed thus
> this feature is kind of risky.

This last sentence is not very idiomatic.

I would suggest:
"However, error-handling is not implemented, which makes the feature
somewhat risky."

> If "Hibernate Enter" or "Hibernate Exit" fail happens

I would suggest:
If either "Hibernate Enter" or "Hibernate Exit" fail during ...

> during auto-hibern8 flow, the corresponding interrupt
> "UIC_HIBERNATE_ENTER" or "UIC_HIBERNATE_EXIT" shall be raised
> according to UFS specification.
> 
> This patch adds auto-hibern8 error handlings:

error-handling

> - Monitor "Hibernate Enter" and "Hibernate Exit" interrupts after
>   auto-hibern8 feature is activated.

I just want to take this opportunity to ask a rhetorical question.

Who in the Great Heavens thought it would be a good idea to call the
feature "auto-hibern8" ?

Was it really worth it to save 2 characters by writing "8" instead
of "ate" ?

This bugs me so much that I just might send a patch to fix it up.

Regards.
