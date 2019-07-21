Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C03416F3A9
	for <lists+linux-scsi@lfdr.de>; Sun, 21 Jul 2019 16:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfGUO1y (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 21 Jul 2019 10:27:54 -0400
Received: from condef-08.nifty.com ([202.248.20.73]:32629 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfGUO1x (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 21 Jul 2019 10:27:53 -0400
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-08.nifty.com with ESMTP id x6LEPh3e024062
        for <linux-scsi@vger.kernel.org>; Sun, 21 Jul 2019 23:25:44 +0900
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x6LEP6So028038;
        Sun, 21 Jul 2019 23:25:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x6LEP6So028038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563719106;
        bh=s33EX00wTiBe9Bau2mAVNBRw2u1DMafGh9Oh+rM2cNk=;
        h=From:To:Cc:Subject:Date:From;
        b=BwU/A5h4kRa6W4caGY0ekKCsMx/zOUmTdqcbUCLogAedBXbl8IB+3Unpc2psgl1C2
         pak7DFhwiWg3QPz8AgwmX2toPhin+YxS+B5GC2p2HaVkx+3JjPmCVyLLb9Dz13kE/v
         mUDi+fHumqxyHwI38+A3z+QDHugw924uNpaMRbDPYpFv9iHVkTneI9aZS6/Jxu6M9Q
         r2QdWOzgfFHV5Dz/rJXn2cUWtMVIpObtCxWOzxK6lhWgcYUA7Gm3u8K3BL2cOP3M9A
         ToYeNwCZqTqzGAeudtLgwU5+MTMegoBv6ypXqhu4tihavOuyvyjyH5rH4S+ZhPsS31
         OIenvHnYrPFqw==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: use __u{8,16,32,64} instead of uint{8,16,32,64}_t in uapi headers
Date:   Sun, 21 Jul 2019 23:25:02 +0900
Message-Id: <20190721142502.30599-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When CONFIG_UAPI_HEADER_TEST=y, exported headers are compile-tested to
make sure they can be included from user-space.

Currently, scsi_bsg_fc.h, scsi_netlink.h, and scsi_netlink_fc.h are
excluded from the test coverage. To make them join the compile-test,
we need to fix the build errors attached below.

For a case like this, we decided to use __u{8,16,32,64} variable types
in this discussion:

  https://lkml.org/lkml/2019/6/5/18

Build log:

  CC      usr/include/scsi/scsi_netlink_fc.h.s
  CC      usr/include/scsi/scsi_netlink.h.s
  CC      usr/include/scsi/scsi_bsg_fc.h.s
In file included from ./usr/include/scsi/scsi_netlink_fc.h:10:0,
                 from <command-line>:32:
./usr/include/scsi/scsi_netlink.h:29:2: error: unknown type name ‘uint8_t’
  uint8_t version;
  ^~~~~~~
./usr/include/scsi/scsi_netlink.h:30:2: error: unknown type name ‘uint8_t’
  uint8_t transport;
  ^~~~~~~
./usr/include/scsi/scsi_netlink.h:31:2: error: unknown type name ‘uint16_t’
  uint16_t magic;
  ^~~~~~~~
./usr/include/scsi/scsi_netlink.h:32:2: error: unknown type name ‘uint16_t’
  uint16_t msgtype;
  ^~~~~~~~
  CC      usr/include/rdma/vmw_pvrdma-abi.h.s
./usr/include/scsi/scsi_netlink.h:33:2: error: unknown type name ‘uint16_t’
  uint16_t msglen;
  ^~~~~~~~
./usr/include/scsi/scsi_netlink.h:34:33: error: ‘uint64_t’ undeclared here (not in a function); did you mean ‘__uint128_t’?
 } __attribute__((aligned(sizeof(uint64_t))));
                                 ^~~~~~~~
                                 __uint128_t
./usr/include/scsi/scsi_netlink.h:78:2: error: expected specifier-qualifier-list before ‘uint64_t’
  uint64_t vendor_id;
  ^~~~~~~~
In file included from <command-line>:32:0:
./usr/include/scsi/scsi_netlink_fc.h:46:2: error: expected specifier-qualifier-list before ‘uint64_t’
  uint64_t seconds;
  ^~~~~~~~
make[2]: *** [scripts/Makefile.build;302: usr/include/scsi/scsi_netlink_fc.h.s] Error 1
make[2]: *** Waiting for unfinished jobs....
In file included from <command-line>:32:0:
./usr/include/scsi/scsi_netlink.h:29:2: error: unknown type name ‘uint8_t’
  uint8_t version;
  ^~~~~~~
./usr/include/scsi/scsi_netlink.h:30:2: error: unknown type name ‘uint8_t’
  uint8_t transport;
  ^~~~~~~
./usr/include/scsi/scsi_netlink.h:31:2: error: unknown type name ‘uint16_t’
  uint16_t magic;
  ^~~~~~~~
./usr/include/scsi/scsi_netlink.h:32:2: error: unknown type name ‘uint16_t’
  uint16_t msgtype;
  ^~~~~~~~
./usr/include/scsi/scsi_netlink.h:33:2: error: unknown type name ‘uint16_t’
  uint16_t msglen;
  ^~~~~~~~
./usr/include/scsi/scsi_netlink.h:34:33: error: ‘uint64_t’ undeclared here (not in a function); did you mean ‘__uint128_t’?
 } __attribute__((aligned(sizeof(uint64_t))));
                                 ^~~~~~~~
                                 __uint128_t
./usr/include/scsi/scsi_netlink.h:78:2: error: expected specifier-qualifier-list before ‘uint64_t’
  uint64_t vendor_id;
  ^~~~~~~~
make[2]: *** [scripts/Makefile.build;302: usr/include/scsi/scsi_netlink.h.s] Error 1
In file included from <command-line>:32:0:
./usr/include/scsi/scsi_bsg_fc.h:69:2: error: unknown type name ‘uint8_t’
  uint8_t  reserved;
  ^~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:72:2: error: unknown type name ‘uint8_t’
  uint8_t  port_id[3];
  ^~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:90:2: error: unknown type name ‘uint8_t’
  uint8_t  reserved;
  ^~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:93:2: error: unknown type name ‘uint8_t’
  uint8_t  port_id[3];
  ^~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:114:2: error: unknown type name ‘uint8_t’
  uint8_t  command_code;
  ^~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:117:2: error: unknown type name ‘uint8_t’
  uint8_t  port_id[3];
  ^~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:154:2: error: unknown type name ‘uint32_t’
  uint32_t status;  /* See FC_CTELS_STATUS_xxx */
  ^~~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:158:3: error: unknown type name ‘uint8_t’
   uint8_t action;  /* fragment_id for CT REJECT */
   ^~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:159:3: error: unknown type name ‘uint8_t’
   uint8_t reason_code;
   ^~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:160:3: error: unknown type name ‘uint8_t’
   uint8_t reason_explanation;
   ^~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:161:3: error: unknown type name ‘uint8_t’
   uint8_t vendor_unique;
   ^~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:177:2: error: unknown type name ‘uint8_t’
  uint8_t  reserved;
  ^~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:180:2: error: unknown type name ‘uint8_t’
  uint8_t  port_id[3];
  ^~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:185:2: error: unknown type name ‘uint32_t’
  uint32_t preamble_word0; /* revision & IN_ID */
  ^~~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:186:2: error: unknown type name ‘uint32_t’
  uint32_t preamble_word1; /* GS_Type, GS_SubType, Options, Rsvd */
  ^~~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:187:2: error: unknown type name ‘uint32_t’
  uint32_t preamble_word2; /* Cmd Code, Max Size */
  ^~~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:207:2: error: unknown type name ‘uint64_t’
  uint64_t vendor_id;
  ^~~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:210:2: error: unknown type name ‘uint32_t’
  uint32_t vendor_cmd[0];
  ^~~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:217:2: error: unknown type name ‘uint32_t’
  uint32_t vendor_rsp[0];
  ^~~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:236:2: error: unknown type name ‘uint8_t’
  uint8_t els_code;
  ^~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:254:2: error: unknown type name ‘uint32_t’
  uint32_t preamble_word0; /* revision & IN_ID */
  ^~~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:255:2: error: unknown type name ‘uint32_t’
  uint32_t preamble_word1; /* GS_Type, GS_SubType, Options, Rsvd */
  ^~~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:256:2: error: unknown type name ‘uint32_t’
  uint32_t preamble_word2; /* Cmd Code, Max Size */
  ^~~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:268:2: error: unknown type name ‘uint32_t’
  uint32_t msgcode;
  ^~~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:292:2: error: unknown type name ‘uint32_t’
  uint32_t result;
  ^~~~~~~~
./usr/include/scsi/scsi_bsg_fc.h:295:2: error: unknown type name ‘uint32_t’
  uint32_t reply_payload_rcv_len;
  ^~~~~~~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/uapi/scsi/scsi_bsg_fc.h     | 54 +++++++++++++++--------------
 include/uapi/scsi/scsi_netlink.h    | 20 +++++------
 include/uapi/scsi/scsi_netlink_fc.h | 17 ++++-----
 3 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/include/uapi/scsi/scsi_bsg_fc.h b/include/uapi/scsi/scsi_bsg_fc.h
index 52f32a60d056..3ae65e93235c 100644
--- a/include/uapi/scsi/scsi_bsg_fc.h
+++ b/include/uapi/scsi/scsi_bsg_fc.h
@@ -8,6 +8,8 @@
 #ifndef SCSI_BSG_FC_H
 #define SCSI_BSG_FC_H
 
+#include <linux/types.h>
+
 /*
  * This file intended to be included by both kernel and user space
  */
@@ -66,10 +68,10 @@
  * with the transport upon completion of the login.
  */
 struct fc_bsg_host_add_rport {
-	uint8_t		reserved;
+	__u8	reserved;
 
 	/* FC Address Identier of the remote port to login to */
-	uint8_t		port_id[3];
+	__u8	port_id[3];
 };
 
 /* Response:
@@ -87,10 +89,10 @@ struct fc_bsg_host_add_rport {
  * remain logged in with the remote port.
  */
 struct fc_bsg_host_del_rport {
-	uint8_t		reserved;
+	__u8	reserved;
 
 	/* FC Address Identier of the remote port to logout of */
-	uint8_t		port_id[3];
+	__u8	port_id[3];
 };
 
 /* Response:
@@ -111,10 +113,10 @@ struct fc_bsg_host_els {
 	 * ELS Command Code being sent (must be the same as byte 0
 	 * of the payload)
 	 */
-	uint8_t 	command_code;
+	__u8	command_code;
 
 	/* FC Address Identier of the remote port to send the ELS to */
-	uint8_t		port_id[3];
+	__u8	port_id[3];
 };
 
 /* Response:
@@ -151,14 +153,14 @@ struct fc_bsg_ctels_reply {
 	 * Note: x_RJT/BSY status will indicae that the rjt_data field
 	 *   is valid and contains the reason/explanation values.
 	 */
-	uint32_t	status;		/* See FC_CTELS_STATUS_xxx */
+	__u32	status;		/* See FC_CTELS_STATUS_xxx */
 
 	/* valid if status is not FC_CTELS_STATUS_OK */
 	struct	{
-		uint8_t	action;		/* fragment_id for CT REJECT */
-		uint8_t	reason_code;
-		uint8_t	reason_explanation;
-		uint8_t	vendor_unique;
+		__u8	action;		/* fragment_id for CT REJECT */
+		__u8	reason_code;
+		__u8	reason_explanation;
+		__u8	vendor_unique;
 	} rjt_data;
 };
 
@@ -174,17 +176,17 @@ struct fc_bsg_ctels_reply {
  * and whether to tear it down after the request.
  */
 struct fc_bsg_host_ct {
-	uint8_t		reserved;
+	__u8	reserved;
 
 	/* FC Address Identier of the remote port to send the ELS to */
-	uint8_t		port_id[3];
+	__u8	port_id[3];
 
 	/*
 	 * We need words 0-2 of the generic preamble for the LLD's
 	 */
-	uint32_t	preamble_word0;	/* revision & IN_ID */
-	uint32_t	preamble_word1;	/* GS_Type, GS_SubType, Options, Rsvd */
-	uint32_t	preamble_word2;	/* Cmd Code, Max Size */
+	__u32	preamble_word0;	/* revision & IN_ID */
+	__u32	preamble_word1;	/* GS_Type, GS_SubType, Options, Rsvd */
+	__u32	preamble_word2;	/* Cmd Code, Max Size */
 
 };
 /* Response:
@@ -204,17 +206,17 @@ struct fc_bsg_host_vendor {
 	 * Identifies the vendor that the message is formatted for. This
 	 * should be the recipient of the message.
 	 */
-	uint64_t vendor_id;
+	__u64 vendor_id;
 
 	/* start of vendor command area */
-	uint32_t vendor_cmd[0];
+	__u32 vendor_cmd[0];
 };
 
 /* Response:
  */
 struct fc_bsg_host_vendor_reply {
 	/* start of vendor response area */
-	uint32_t vendor_rsp[0];
+	__u32 vendor_rsp[0];
 };
 
 
@@ -233,7 +235,7 @@ struct fc_bsg_rport_els {
 	 * ELS Command Code being sent (must be the same as
 	 * byte 0 of the payload)
 	 */
-	uint8_t els_code;
+	__u8 els_code;
 };
 
 /* Response:
@@ -251,9 +253,9 @@ struct fc_bsg_rport_ct {
 	/*
 	 * We need words 0-2 of the generic preamble for the LLD's
 	 */
-	uint32_t	preamble_word0;	/* revision & IN_ID */
-	uint32_t	preamble_word1;	/* GS_Type, GS_SubType, Options, Rsvd */
-	uint32_t	preamble_word2;	/* Cmd Code, Max Size */
+	__u32	preamble_word0;	/* revision & IN_ID */
+	__u32	preamble_word1;	/* GS_Type, GS_SubType, Options, Rsvd */
+	__u32	preamble_word2;	/* Cmd Code, Max Size */
 };
 /* Response:
  *
@@ -265,7 +267,7 @@ struct fc_bsg_rport_ct {
 
 /* request (CDB) structure of the sg_io_v4 */
 struct fc_bsg_request {
-	uint32_t msgcode;
+	__u32 msgcode;
 	union {
 		struct fc_bsg_host_add_rport	h_addrport;
 		struct fc_bsg_host_del_rport	h_delrport;
@@ -289,10 +291,10 @@ struct fc_bsg_reply {
 	 *    msg and status fields. The per-msgcode reply structure
 	 *    will contain valid data.
 	 */
-	uint32_t result;
+	__u32 result;
 
 	/* If there was reply_payload, how much was recevied ? */
-	uint32_t reply_payload_rcv_len;
+	__u32 reply_payload_rcv_len;
 
 	union {
 		struct fc_bsg_host_vendor_reply		vendor_reply;
diff --git a/include/uapi/scsi/scsi_netlink.h b/include/uapi/scsi/scsi_netlink.h
index 5dd382054e45..1b1737c3c9d8 100644
--- a/include/uapi/scsi/scsi_netlink.h
+++ b/include/uapi/scsi/scsi_netlink.h
@@ -26,12 +26,12 @@
 
 /* SCSI_TRANSPORT_MSG event message header */
 struct scsi_nl_hdr {
-	uint8_t version;
-	uint8_t transport;
-	uint16_t magic;
-	uint16_t msgtype;
-	uint16_t msglen;
-} __attribute__((aligned(sizeof(uint64_t))));
+	__u8 version;
+	__u8 transport;
+	__u16 magic;
+	__u16 msgtype;
+	__u16 msglen;
+} __attribute__((aligned(sizeof(__u64))));
 
 /* scsi_nl_hdr->version value */
 #define SCSI_NL_VERSION				1
@@ -75,10 +75,10 @@ struct scsi_nl_hdr {
  */
 struct scsi_nl_host_vendor_msg {
 	struct scsi_nl_hdr snlh;		/* must be 1st element ! */
-	uint64_t vendor_id;
-	uint16_t host_no;
-	uint16_t vmsg_datalen;
-} __attribute__((aligned(sizeof(uint64_t))));
+	__u64 vendor_id;
+	__u16 host_no;
+	__u16 vmsg_datalen;
+} __attribute__((aligned(sizeof(__u64))));
 
 
 /*
diff --git a/include/uapi/scsi/scsi_netlink_fc.h b/include/uapi/scsi/scsi_netlink_fc.h
index a39023579051..7535253f1a96 100644
--- a/include/uapi/scsi/scsi_netlink_fc.h
+++ b/include/uapi/scsi/scsi_netlink_fc.h
@@ -7,6 +7,7 @@
 #ifndef SCSI_NETLINK_FC_H
 #define SCSI_NETLINK_FC_H
 
+#include <linux/types.h>
 #include <scsi/scsi_netlink.h>
 
 /*
@@ -43,14 +44,14 @@
  */
 struct fc_nl_event {
 	struct scsi_nl_hdr snlh;		/* must be 1st element ! */
-	uint64_t seconds;
-	uint64_t vendor_id;
-	uint16_t host_no;
-	uint16_t event_datalen;
-	uint32_t event_num;
-	uint32_t event_code;
-	uint32_t event_data;
-} __attribute__((aligned(sizeof(uint64_t))));
+	__u64 seconds;
+	__u64 vendor_id;
+	__u16 host_no;
+	__u16 event_datalen;
+	__u32 event_num;
+	__u32 event_code;
+	__u32 event_data;
+} __attribute__((aligned(sizeof(__u64))));
 
 
 #endif /* SCSI_NETLINK_FC_H */
-- 
2.17.1

