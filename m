Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66150331D6C
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Mar 2021 04:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhCIDWI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 8 Mar 2021 22:22:08 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:44838 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhCIDWD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 8 Mar 2021 22:22:03 -0500
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Mar 2021 22:22:02 EST
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 85B714002B1;
        Tue,  9 Mar 2021 11:16:35 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     daejun7.park@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>, Bean Huo <beanhuo@micron.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kaixian.yang@vivo.com, wangqing@vivo.com
Subject: Re: [PATCH] [v26,1/4] scsi: ufs: Introduce HPB feature
Date:   Tue,  9 Mar 2021 11:15:38 +0800
Message-Id: <1615259740-24629-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20210303062800epcms2p1c14c69e74782f25aaaef808ae625d701@epcms2p1>
References: <20210303062800epcms2p1c14c69e74782f25aaaef808ae625d701@epcms2p1>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHRgYTEIeTUpISU4eVkpNSk5JTkJMQk1KSEpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTY6Qio5Aj8JFw4sP0NJMk8y
        HTUwCQlVSlVKTUpOSU5CTEJNTktDVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTUNDNwY+
X-HM-Tid: 0a7814fc8231d991kuws85b714002b1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

