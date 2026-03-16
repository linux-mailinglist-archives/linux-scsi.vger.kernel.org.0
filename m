Return-Path: <linux-scsi+bounces-22056-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPEIAPgkuGmNZgEAu9opvQ
	(envelope-from <linux-scsi+bounces-22056-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2026 16:42:48 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8606129CA2A
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2026 16:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3194B306B168
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2026 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986B33A1A5D;
	Mon, 16 Mar 2026 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DsENwmQS"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730C3A1A5C;
	Mon, 16 Mar 2026 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675236; cv=none; b=PtOwSOOGwLrOUpxwtOm2SiQvATxiMZFy3IF92HJxL92KYfqx9VqsiwW0FwrQIXgLy0Ked5QjU22+OLl8k+CD5KGC7Jhs3uswHjh2t05QPCREUo5tjdDP9GuYR5DhDTL9y93Rwg5uUqP6FsFV7OoZN4bI3rBSIHTbxFXT/ZGQg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675236; c=relaxed/simple;
	bh=MerWGEPCfHOE/BqkAdPV4miDaltpJHzG1mjvxxsWEiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qC6z+Aye89HEIXDpovqdFmVwjQdjOgJC7+vSwzGKwXqMtbzk5wRAqwrEjeWm/ebNX/vM31FH7SoB86RPm2PHZFN1UhKMs6X6YugTLsMIrxLGPgvUSBXSAbuwwVdMCgGB/kIibf1sK+oOx8FsxJjO4AbMp+whxPHb75COkDNH8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DsENwmQS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G3UJdH1503327;
	Mon, 16 Mar 2026 15:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YJvF+zi5H2cRaSITPz6mnJIQpbkX1+yfVis1PQaEY
	dg=; b=DsENwmQSJTFteE7bw/Ji5ol4rUnOFp5ucyLwB6Vh0h/nf6SkJ/WU95Whb
	XbJSrl2G+O0NuNhNdaCD4oXN2j2Z9fURyxctLcMiSYBWWGpVZaETdf1PIzC7AbTG
	NqCOd7exFmGwt2raYq3Kr+hjFxrO+ZhHC2s7UlmxxlNnKdoY9qmoXlYNAaCSyj4p
	juVuhlqEWFvewJO7IU9BYxfCYWDb7isOkJKT5ohp/FQFWiKG3tFjCDHNKjGik1my
	C20rZv/zESETSMKw92AgvbickpxboXELEGx2dAt52E1DJ0UV50jXI0kb09krhhB0
	+XvwW6ghkrzIzs9YPDuf89zN4IhaA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hrd30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 15:33:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GEhJra014033;
	Mon, 16 Mar 2026 15:33:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcxwe4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 15:33:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GFXgRU51380698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 15:33:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 567692004B;
	Mon, 16 Mar 2026 15:33:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C7E020043;
	Mon, 16 Mar 2026 15:33:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 16 Mar 2026 15:33:42 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56370)
	id F1EC8E03BA; Mon, 16 Mar 2026 16:33:41 +0100 (CET)
From: Joshua Daley <jdaley@linux.ibm.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        jdaley@linux.ibm.com, mst@redhat.com, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        mjrosato@linux.ibm.com, farman@linux.ibm.com, frankja@linux.ibm.com
Subject: [PATCH v3 0/3] scsi: virtio_scsi: move INIT_WORK calls to virtscsi_init
Date: Mon, 16 Mar 2026 16:33:38 +0100
Message-ID: <20260316153341.2062278-1-jdaley@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dhOyTImQNyg2edgN4EwowWy51j15MhAk
X-Proofpoint-ORIG-GUID: dhOyTImQNyg2edgN4EwowWy51j15MhAk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDExNCBTYWx0ZWRfX0he2FHl5sKFQ
 Om9w1kL1hZ0YzabdmYluJvQWkb6XozDQNdsFblPKDeiPFG/yuefWDDbKzE8Pli1ztcZMo1o05do
 NLguj8CgITDcGlLGEpE5ImkENJ28z8EAVQMfJT92E6blM1bGb7utD9aj7ywmQ4ikvJKL7pRcKZb
 EVlLSakA9ORkNCWn9NA2xiYJFtfN1DYCmF+VEwCia/8uKLRaC4J9ca75IyW7OxfJd0ZOxq3Buir
 P4m7YRlvdKL+lwvHzv7BdtOAByW+lgQhfFUfgRtvygOZGDF913G7XkADW89l/ei75Ul38Y9v9mz
 02h8whwjL3SnryNZE0Tt/QxNt+zCjwC/De8ah2doHj6t1e/2pg2Wp+XfkGsdyL2jeiQfZXN2cDO
 cpmNbWohBpHqmjTP+Q/r49nTO7kF6Je8PbKyrtFvQo59GUevYg6UwhbjnkqCSPA2OaE7H38V9VT
 5oy4DGmmAhX6WgwM1cA==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b822db cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=CFRfbv1PXe9UI1TNNxIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160114
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22056-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jdaley@linux.ibm.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8606129CA2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Changelog v2 -> v3:

- switched the order of patches 2 & 3 to fix compilation error.
- added reviewed-by tags.

-----

v2 cover letter:

Changelog v1 -> v2:

- Added 2 additional patches:
  - [PATCH v2 1/3] scsi: virtio_scsi: kick event_list unconditionally
    - Removes the conditions surrounding event_list operations (suggested=
 by Stefan Hajnoczi <stefanha@redhat.com>)
  - [PATCH v2 2/3] scsi: virtio_scsi: remove unnecessary fn declaration
    - Removes virtscsi_handle_event() prototype (suggested by Eric Farman=
 <farman@linux.ibm.com>)

- [PATCH 1/1] -> [PATCH v2 3/3] scsi: virtio_scsi: move INIT_WORK calls t=
o virtscsi_init
  - Removed the condition surrounding INIT_WORK calls

-----

v1 cover letter:

This patch avoids a kernel warning that may occur if a virtio_scsi
controller is detached immediately following a disk detach. See the
commit message for details. The following are instructions to
produce the warning (without the proposed patch).

Timing matters--if all event work items call INIT_WORK before they are
flushed by cancel_work_sync, then the warning will not occur.

The warning will occur consistently if a sleep is added in
virtscsi_kick_event before the INIT_WORK call, like so:

#include <linux/delay.h>

static int virtscsi_kick_event(struct virtio_scsi *vscsi,
			       struct virtio_scsi_event_node *event_node)
{
    int err;
    struct scatterlist sg;
    unsigned long flags;

 -> msleep(1000);
    INIT_WORK(&event_node->work, virtscsi_handle_event);
=09
    ...
}

Then, just detach a disk and its controller in quick succession:

virsh detach-device --domain <domain> disk.xml; \
virsh detach-device --domain <domain> controller.xml

where disk.xml and controller.xml are text files containing the XML
of the disk and controller.

Or, with the libvirt python module:

domain.detachDevice(str(disk_xml))
domain.detachDevice(str(controller_xml))

Joshua Daley (3):
  scsi: virtio_scsi: kick event_list unconditionally
  scsi: virtio_scsi: move INIT_WORK calls to virtscsi_init
  scsi: virtio_scsi: remove unnecessary fn declaration

 drivers/scsi/virtio_scsi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

--=20
2.34.1


