Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6A67D83EB
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Oct 2023 15:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjJZNyf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 26 Oct 2023 09:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZNye (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 26 Oct 2023 09:54:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFFDBD
        for <linux-scsi@vger.kernel.org>; Thu, 26 Oct 2023 06:54:32 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QDejWn007018;
        Thu, 26 Oct 2023 13:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=W3cQ0whKEbnextdPCKUfC0w0F3B6cwaLIs6azGprPtw=;
 b=GsTVgrS7s6CJ2Bw8s0su7YAoh0bwrHuBzDjQUKI22sVPidYWQSViJipFQ8eNItTI0qd1
 U/jMZXzJOcg1DRRlvdoSVdgUewAUrERwC2B8il/1jH4xys13D5aKqFhz/t/jrxL7fWv4
 lkq0cRNhBfjR4mwraaec5+cpTzTmyldbNGGFHe1lYEqRItsWBWLE21kGVw62fHp5MHc+
 oDmtr/ixsmZ4d7ZjUeevFJW0LpAE0AwXl0IAjQprCBr33O9TU8genUACLny+l/28zZdG
 2H7fr/4XwxPUi8zUEtaWojFsL+eiJa14ZQP0DXqvDqHeRpeNQsQOuNtKiZElVZaFLP2m ig== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tys74gdah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 13:54:24 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39QBk7kt026853;
        Thu, 26 Oct 2023 13:54:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsyp6db8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 13:54:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39QDsK2130671406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 13:54:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 081AA2004B;
        Thu, 26 Oct 2023 13:54:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED79120049;
        Thu, 26 Oct 2023 13:54:19 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.152.212.253])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Oct 2023 13:54:19 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.96.1)
        (envelope-from <bblock@linux.ibm.com>)
        id 1qw0oV-00AqtG-2I;
        Thu, 26 Oct 2023 15:54:19 +0200
Date:   Thu, 26 Oct 2023 15:54:19 +0200
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 08/10] scsi_error: iterate over list of failed commands
 in scsi_eh_bus_device_reset()
Message-ID: <20231026135419.GN1917450@p1gen4-pw042f0m.boeblingen.de.ibm.com>
References: <20231023092837.33786-1-hare@suse.de>
 <20231023092837.33786-9-hare@suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20231023092837.33786-9-hare@suse.de>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m6renNIhYpZn_KfwwxxDE3GFnKHrYhWk
X-Proofpoint-GUID: m6renNIhYpZn_KfwwxxDE3GFnKHrYhWk
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_12,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Oct 23, 2023 at 11:28:35AM +0200, Hannes Reinecke wrote:
>  			SCSI_LOG_ERROR_RECOVERY(3,
>  				sdev_printk(KERN_INFO, sdev,
>  					    "%s: BDR failed\n", current->comm));
> +		list_for_each_entry_safe(scmd, next, work_q, eh_entry) {

Same as before, you want to loop over the new `tmp_list`, `work_q` should be
empty here.

> +			if (scmd->device != sdev)
> +				continue;
> +			if (rtn == SUCCESS)
> +				list_move_tail(&scmd->eh_entry, &check_list);
> +			else if (rtn == FAST_IO_FAIL) {
> +				set_host_byte(scmd, DID_TRANSPORT_FAILFAST);
> +				scsi_eh_finish_cmd(scmd, done_q);
> +			}
>  		}

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Gregor Pillen         /         Gesch�ftsf�hrung: David Faller
Sitz der Ges.: B�blingen     /    Registergericht: AmtsG Stuttgart, HRB 243294
