Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1BC7413A
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jul 2019 00:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfGXWIS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Jul 2019 18:08:18 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:62817 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfGXWIS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 24 Jul 2019 18:08:18 -0400
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=don.brace@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  don.brace@microsemi.com designates 208.19.100.22 as permitted
  sender) identity=mailfrom; client-ip=208.19.100.22;
  receiver=esa6.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="don.brace@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.22; receiver=esa6.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
X-Ironport-Dmarc-Check-Result: validskip
IronPort-SDR: e00nho+R8NgiABAGBDxWMc94d155GyRiVl+L0LoHWbdkTBlGRspP1lFU+Ei28YaIP2wDwgydmU
 4Kuz2yA2jJvHp9UxgT5RzVEnAVmp3OWY5h19x5lcKDeOu7+8d4Kl3ljdHNYNXdD27YClhWXNXX
 FySAGcnvI0nGmKnpDjItBs8XgMoin4v887ChQwVv/cIY8SWgLqQlYU3lwM1yDD9GSwCFPqJD2S
 Et8eJMs5vgoSuVgPjEovg8xz0ZiL8ow7dLo2NWuT3uIWvhUK5mRSRWDc0Vkr47W1ZBm5MQsQFs
 cPQ=
X-IronPort-AV: E=Sophos;i="5.64,304,1559545200"; 
   d="scan'208";a="39592180"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2019 15:08:01 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 24 Jul
 2019 15:08:00 -0700
Received: from [127.0.1.1] (10.238.32.34) by avmbx3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 24 Jul 2019 15:08:00 -0700
Subject: [PATCH 0/2] hpsa updates
From:   Don Brace <don.brace@microsemi.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Wed, 24 Jul 2019 17:07:59 -0500
Message-ID: <156400599822.14150.10317539253759491318.stgit@brunhilda>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

These patches are based on Linus's tree

The changes are:
hpsa-correct-scsi-command-status-issue-after-reset
 . ensure command status is 0 for submitted commands.
hpsa-remove-printing-internal-cdb-on-tag-collision
 . remove racy call to print an scsi command from our internal
   submission queue.
   . completion thread can be cleaning up the command in parallel

---

Don Brace (2):
      hpsa: correct scsi command status issue after reset
      hpsa: remove printing internal cdb on tag collision


 drivers/scsi/hpsa.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--
Signature
